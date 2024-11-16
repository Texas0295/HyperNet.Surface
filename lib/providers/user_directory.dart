import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/account.dart';

class UserDirectoryProvider {
  late final SnNetworkProvider _sn;

  UserDirectoryProvider(BuildContext context) {
    _sn = context.read<SnNetworkProvider>();
  }

  final Map<String, int> _idCache = {};
  final Map<int, SnAccount> _cache = {};

  Future<List<SnAccount?>> listAccount(Iterable<dynamic> id) async {
    final out = await Future.wait(
      id.map((e) => getAccount(e)),
    );
    return out;
  }

  Future<SnAccount?> getAccount(dynamic id) async {
    if (id is String && _idCache.containsKey(id)) {
      id = _idCache[id];
    }
    if (_cache.containsKey(id)) {
      return _cache[id];
    }

    try {
      final resp = await _sn.client.get('/cgi/id/users/$id');
      final account = SnAccount.fromJson(
        resp.data as Map<String, dynamic>,
      );
      _cache[account.id] = account;
      if (id is String) _idCache[id] = account.id;
      return account;
    } catch (err) {
      return null;
    }
  }

  SnAccount? getAccountFromCache(dynamic id) {
    if (id is String && _idCache.containsKey(id)) {
      id = _idCache[id];
    }
    return _cache[id];
  }
}
