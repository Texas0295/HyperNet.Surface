import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_attachment.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/user_directory.dart';
import 'package:surface/types/post.dart';

class SnPostContentProvider {
  late final SnNetworkProvider _sn;
  late final UserDirectoryProvider _ud;
  late final SnAttachmentProvider _attach;

  SnPostContentProvider(BuildContext context) {
    _sn = context.read<SnNetworkProvider>();
    _ud = context.read<UserDirectoryProvider>();
    _attach = context.read<SnAttachmentProvider>();
  }

  Future<List<SnPost>> _preloadRelatedDataInBatch(List<SnPost> out) async {
    Set<String> rids = {};
    for (var i = 0; i < out.length; i++) {
      rids.addAll(out[i].body['attachments']?.cast<String>() ?? []);
      if (out[i].body['thumbnail'] != null) {
        rids.add(out[i].body['thumbnail']);
      }
      if (out[i].repostTo != null) {
        out[i] = out[i].copyWith(
          repostTo: await _preloadRelatedDataSingle(out[i].repostTo!),
        );
      }
    }

    final attachments = await _attach.getMultiple(rids.toList());
    for (var i = 0; i < out.length; i++) {
      out[i] = out[i].copyWith(
        preload: SnPostPreload(
          thumbnail: attachments.where((ele) => ele?.rid == out[i].body['thumbnail']).firstOrNull,
          attachments: attachments.where((ele) => out[i].body['attachments']?.contains(ele?.rid) ?? false).toList(),
        ),
      );
    }

    await _ud.listAccount(
      attachments.where((ele) => ele != null).map((ele) => ele!.accountId).toSet(),
    );

    return out;
  }

  Future<SnPost> _preloadRelatedDataSingle(SnPost out) async {
    Set<String> rids = {};
    rids.addAll(out.body['attachments']?.cast<String>() ?? []);
    if (out.body['thumbnail'] != null) {
      rids.add(out.body['thumbnail']);
    }
    if (out.repostTo != null) {
      out = out.copyWith(
        repostTo: await _preloadRelatedDataSingle(out.repostTo!),
      );
    }

    final attachments = await _attach.getMultiple(rids.toList());
    out = out.copyWith(
      preload: SnPostPreload(
        thumbnail: attachments.where((ele) => ele?.rid == out.body['thumbnail']).firstOrNull,
        attachments: attachments.where((ele) => out.body['attachments']?.contains(ele?.rid) ?? false).toList(),
      ),
    );

    return out;
  }

  Future<List<SnPost>> listRecommendations() async {
    final resp = await _sn.client.get('/cgi/co/recommendations');
    final out = _preloadRelatedDataInBatch(
      List.from(resp.data.map((ele) => SnPost.fromJson(ele))),
    );
    return out;
  }

  Future<(List<SnPost>, int)> listPosts({
    int take = 10,
    int offset = 0,
    String? type,
    String? author,
  }) async {
    final resp = await _sn.client.get('/cgi/co/posts', queryParameters: {
      'take': take,
      'offset': offset,
      if (type != null) 'type': type,
      if (author != null) 'author': author,
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
    final resp = await _sn.client.get('/cgi/co/posts/$parentId/replies', queryParameters: {
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
    Iterable<String>? tags,
  }) async {
    final resp = await _sn.client.get('/cgi/co/posts/search', queryParameters: {
      'take': take,
      'offset': offset,
      'probe': searchTerm,
      if (tags?.isNotEmpty ?? false) 'tags': tags!.join(','),
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
