import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_attachment.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/post.dart';

class SnPostContentProvider {
  late final SnNetworkProvider _sn;
  late final SnAttachmentProvider _attach;

  SnPostContentProvider(BuildContext context) {
    _sn = context.read<SnNetworkProvider>();
    _attach = context.read<SnAttachmentProvider>();
  }

  Future<List<SnPost>> _preloadRelatedDataInBatch(List<SnPost> out) async {
    Set<String> rids = {};
    for (var i = 0; i < out.length; i++) {
      rids.addAll(out[i].body['attachments']?.cast<String>() ?? []);
      if (out[i].body['thumbnail'] != null) {
        rids.add(out[i].body['thumbnail']);
      }
    }

    final attachments = await _attach.getMultiple(rids.toList());
    for (var i = 0; i < out.length; i++) {
      out[i] = out[i].copyWith(
        preload: SnPostPreload(
          thumbnail: attachments
              .where((ele) => ele?.rid == out[i].body['thumbnail'])
              .firstOrNull,
          attachments: attachments
              .where((ele) =>
                  out[i].body['attachments']?.contains(ele?.rid) ?? false)
              .toList(),
        ),
      );
    }

    return out;
  }

  Future<SnPost> _preloadRelatedDataSingle(SnPost out) async {
    Set<String> rids = {};
    rids.addAll(out.body['attachments']?.cast<String>() ?? []);
    if (out.body['thumbnail'] != null) {
      rids.add(out.body['thumbnail']);
    }

    final attachments = await _attach.getMultiple(rids.toList());
    out = out.copyWith(
      preload: SnPostPreload(
        thumbnail: attachments
            .where((ele) => ele?.rid == out.body['thumbnail'])
            .firstOrNull,
        attachments: attachments
            .where(
                (ele) => out.body['attachments']?.contains(ele?.rid) ?? false)
            .toList(),
      ),
    );

    return out;
  }

  Future<(List<SnPost>, int)> listPosts({int take = 10, int offset = 0}) async {
    final resp = await _sn.client.get('/cgi/co/posts', queryParameters: {
      'take': take,
      'offset': offset,
    });
    final List<SnPost> out = await _preloadRelatedDataInBatch(
      List.from(resp.data['data']?.map((e) => SnPost.fromJson(e)) ?? []),
    );

    return (out, resp.data['count'] as int);
  }

  Future<(List<SnPost>, int)> listPostReplies(
    dynamic parentId, {
    int take = 10,
    int offset = 0,
  }) async {
    final resp = await _sn.client
        .get('/cgi/co/posts/$parentId/replies', queryParameters: {
      'take': take,
      'offset': offset,
    });
    final List<SnPost> out = await _preloadRelatedDataInBatch(
      List.from(resp.data['data']?.map((e) => SnPost.fromJson(e)) ?? []),
    );

    return (out, resp.data['count'] as int);
  }

  Future<(List<SnPost>, int)> searchPosts(
    String searchTerm, {
    int take = 10,
    int offset = 0,
  }) async {
    final resp = await _sn.client.get('/cgi/co/posts/search', queryParameters: {
      'take': take,
      'offset': offset,
      'probe': searchTerm,
    });
    final List<SnPost> out = await _preloadRelatedDataInBatch(
      List.from(resp.data['data']?.map((e) => SnPost.fromJson(e)) ?? []),
    );

    return (out, resp.data['count'] as int);
  }

  Future<SnPost> getPost(dynamic id) async {
    final resp = await _sn.client.get('/cgi/co/posts/$id');
    final out = _preloadRelatedDataSingle(
      SnPost.fromJson(resp.data),
    );
    return out;
  }
}
