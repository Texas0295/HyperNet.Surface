import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/attachment.dart';

class SnAttachmentProvider {
  late final SnNetworkProvider sn;

  final Map<String, SnAttachment> _cache = {};

  SnAttachmentProvider(BuildContext context) {
    sn = context.read<SnNetworkProvider>();
  }

  Future<SnAttachment> getOne(String rid, {noCache = false}) async {
    if (!noCache && _cache.containsKey(rid)) {
      return _cache[rid]!;
    }

    final resp = await sn.client.get('/cgi/uc/attachments/$rid/meta');
    final out = SnAttachment.fromJson(resp.data);
    _cache[rid] = out;

    return out;
  }

  Future<List<SnAttachment>> getMultiple(List<String> rids,
      {noCache = false}) async {
    final pendingFetch =
        noCache ? rids : rids.where((rid) => !_cache.containsKey(rid)).toList();

    if (pendingFetch.isEmpty) {
      return rids.map((rid) => _cache[rid]!).toList();
    }

    final resp = await sn.client.get('/cgi/uc/attachments', queryParameters: {
      'take': pendingFetch.length,
      'id': pendingFetch.join(','),
    });
    final out = resp.data['data'].map((e) => SnAttachment.fromJson(e)).toList();

    for (var i = 0; i < out.length; i++) {
      _cache[pendingFetch[i]] = out[i];
    }
    return rids.map((rid) => _cache[rid]!).toList();
  }
}
