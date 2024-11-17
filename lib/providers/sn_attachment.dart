import 'dart:collection';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:cross_file/cross_file.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/attachment.dart';

const kConcurrentUploadChunks = 5;

class SnAttachmentProvider {
  late final SnNetworkProvider _sn;
  final Map<String, SnAttachment> _cache = {};

  SnAttachmentProvider(BuildContext context) {
    _sn = context.read<SnNetworkProvider>();
  }

  void putCache(Iterable<SnAttachment> items, {bool noCheck = false}) {
    for (final item in items) {
      if ((item.isAnalyzed && item.isUploaded) || noCheck) {
        _cache[item.rid] = item;
      }
    }
  }

  Future<SnAttachment> getOne(String rid, {noCache = false}) async {
    if (!noCache && _cache.containsKey(rid)) {
      return _cache[rid]!;
    }

    final resp = await _sn.client.get('/cgi/uc/attachments/$rid/meta');
    final out = SnAttachment.fromJson(resp.data);
    if (out.isAnalyzed && out.isUploaded) {
      _cache[rid] = out;
    }

    return out;
  }

  Future<List<SnAttachment?>> getMultiple(List<String> rids,
      {noCache = false}) async {
    final result = List<SnAttachment?>.filled(rids.length, null);
    final Map<String, int> randomMapping = {};
    for (int i = 0; i < rids.length; i++) {
      final rid = rids[i];
      if (noCache || !_cache.containsKey(rid)) {
        randomMapping[rid] = i;
      } else {
        result[i] = _cache[rid]!;
      }
    }
    final pendingFetch = randomMapping.keys;

    if (pendingFetch.isNotEmpty) {
      final resp = await _sn.client.get(
        '/cgi/uc/attachments',
        queryParameters: {
          'take': pendingFetch.length,
          'id': pendingFetch.join(','),
        },
      );
      final out = resp.data['data']
          .map((e) => e['id'] == 0 ? null : SnAttachment.fromJson(e))
          .toList();

      for (final item in out) {
        if (item.isAnalyzed && item.isUploaded) {
          _cache[item.rid] = item;
        }
        result[randomMapping[item.rid]!] = item;
      }
    }

    return result;
  }

  static Map<String, String> mimetypeOverrides = {
    'mov': 'video/quicktime',
    'mp4': 'video/mp4'
  };

  Future<SnAttachment> directUploadOne(
    Uint8List data,
    String filename,
    String pool,
    Map<String, dynamic>? metadata, {
    String? mimetype,
    Function(double progress)? onProgress,
  }) async {
    final filePayload = MultipartFile.fromBytes(data, filename: filename);
    final fileAlt = filename.contains('.')
        ? filename.substring(0, filename.lastIndexOf('.'))
        : filename;
    final fileExt =
        filename.substring(filename.lastIndexOf('.') + 1).toLowerCase();

    String? mimetypeOverride;
    if (mimetype != null) {
      mimetypeOverride = mimetype;
    } else if (mimetypeOverrides.keys.contains(fileExt)) {
      mimetypeOverride = mimetypeOverrides[fileExt];
    }

    final formData = FormData.fromMap({
      'alt': fileAlt,
      'file': filePayload,
      'pool': pool,
      'metadata': metadata,
      if (mimetypeOverride != null) 'mimetype': mimetypeOverride,
    });
    final resp = await _sn.client.post(
      '/cgi/uc/attachments',
      data: formData,
      onSendProgress: (count, total) {
        if (onProgress != null) {
          onProgress(count / total);
        }
      },
    );

    return SnAttachment.fromJson(resp.data);
  }

  Future<(SnAttachment, int)> chunkedUploadInitialize(
    int size,
    String filename,
    String pool,
    Map<String, dynamic>? metadata,
  ) async {
    final fileAlt = filename.contains('.')
        ? filename.substring(0, filename.lastIndexOf('.'))
        : filename;
    final fileExt =
        filename.substring(filename.lastIndexOf('.') + 1).toLowerCase();

    String? mimetypeOverride;
    if (mimetypeOverrides.keys.contains(fileExt)) {
      mimetypeOverride = mimetypeOverrides[fileExt];
    }

    final resp = await _sn.client.post('/cgi/uc/attachments/multipart', data: {
      'alt': fileAlt,
      'name': filename,
      'pool': pool,
      'metadata': metadata,
      'size': size,
      if (mimetypeOverride != null) 'mimetype': mimetypeOverride,
    });

    return (
      SnAttachment.fromJson(resp.data['meta']),
      resp.data['chunk_size'] as int
    );
  }

  Future<SnAttachment> _chunkedUploadOnePart(
    Uint8List data,
    String rid,
    String cid, {
    Function(double progress)? onProgress,
  }) async {
    final resp = await _sn.client.post(
      '/cgi/uc/attachments/multipart/$rid/$cid',
      data: data,
      options: Options(headers: {'Content-Type': 'application/octet-stream'}),
      onSendProgress: (count, total) {
        if (onProgress != null) {
          onProgress(count / total);
        }
      },
    );

    return SnAttachment.fromJson(resp.data);
  }

  Future<SnAttachment> chunkedUploadParts(
    XFile file,
    SnAttachment place,
    int chunkSize, {
    Function(double progress)? onProgress,
  }) async {
    final Map<String, dynamic> chunks = place.fileChunks ?? {};
    var currentTask = 0;

    final queue = Queue<Future<void>>();
    final activeTasks = <Future<void>>[];

    for (final entry in chunks.entries) {
      queue.add(() async {
        final beginCursor = entry.value * chunkSize;
        final endCursor = math.min<int>(
          (entry.value + 1) * chunkSize,
          await file.length(),
        );
        final data = Uint8List.fromList(await file
            .openRead(beginCursor, endCursor)
            .expand((chunk) => chunk)
            .toList());

        place = await _chunkedUploadOnePart(
          data,
          place.rid,
          entry.key,
          onProgress: (chunkProgress) {
            final overallProgress =
                (currentTask + chunkProgress) / chunks.length;
            if (onProgress != null) {
              onProgress(overallProgress);
            }
          },
        );

        currentTask++;
      }());
    }

    while (queue.isNotEmpty || activeTasks.isNotEmpty) {
      while (activeTasks.length < kConcurrentUploadChunks && queue.isNotEmpty) {
        final task = queue.removeFirst();
        activeTasks.add(task);

        task.then((_) => activeTasks.remove(task));
      }

      if (activeTasks.isNotEmpty) {
        await Future.any(activeTasks);
      }
    }

    return place;
  }
}
