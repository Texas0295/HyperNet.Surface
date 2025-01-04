import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/attachment.dart';

class SnStickerProvider {
  late final SnNetworkProvider _sn;
  final Map<String, SnSticker?> _cache = {};

  SnStickerProvider(BuildContext context) {
    _sn = context.read<SnNetworkProvider>();
  }

  bool hasNotSticker(String alias) {
    return _cache.containsKey(alias) && _cache[alias] == null;
  }

  Future<SnSticker?> lookupSticker(String alias) async {
    if (_cache.containsKey(alias)) {
      return _cache[alias];
    }

    try {
      final resp = await _sn.client.get('/cgi/uc/stickers/lookup/$alias');
      final sticker = SnSticker.fromJson(resp.data);
      _cache[alias] = sticker;

      return sticker;
    } catch (err) {
      _cache[alias] = null;
      log('[Sticker] Failed to lookup sticker $alias: $err');
    }

    return null;
  }
}
