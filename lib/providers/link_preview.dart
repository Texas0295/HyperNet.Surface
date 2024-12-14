import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/link.dart';

class SnLinkPreviewProvider {
  late final SnNetworkProvider _sn;

  final Map<String, SnLinkMeta> _cache = {};

  SnLinkPreviewProvider(BuildContext context) {
    _sn = context.read<SnNetworkProvider>();
  }

  Future<SnLinkMeta?> getLinkMeta(String url) async {
    final b64 = utf8.fuse(base64Url);
    final target = b64.encode(url);
    if (_cache.containsKey(target)) return _cache[target];

    log('[LinkPreview] Fetching $url ($target)');

    try {
      final resp = await _sn.client.get('/cgi/re/link/$target');
      final meta = SnLinkMeta.fromJson(resp.data);
      _cache[url] = meta;
      return meta;
    } catch (err) {
      log('[LinkPreview] Failed to fetch $url ($target)');
      return null;
    }
  }
}
