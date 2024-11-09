import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/account.dart';

class UserProvider extends ChangeNotifier {
  bool isAuthorized = false;
  SnAccount? user;

  late final SnNetworkProvider _sn;
  late final FlutterSecureStorage _storage = FlutterSecureStorage();

  UserProvider(BuildContext context) {
    _sn = context.read<SnNetworkProvider>();

    _storage.read(key: kAtkStoreKey).then((value) {
      isAuthorized = value != null;
      notifyListeners();
      refreshUser().then((value) {
        if (value != null) {
          log('Logged in as @${value.name}');
        }
      });
    });
  }

  Future<SnAccount?> refreshUser() async {
    if (!isAuthorized) return null;

    final resp = await _sn.client.get('/cgi/id/users/me');
    final out = SnAccount.fromJson(resp.data);

    user = out;
    notifyListeners();

    return out;
  }

  void logoutUser() async {
    _sn.clearTokenPair();
    isAuthorized = false;
    user = null;
    notifyListeners();
  }
}
