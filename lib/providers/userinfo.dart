import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/account.dart';

class UserProvider extends ChangeNotifier {
  bool isAuthorized = false;
  SnAccount? user;

  late final SnNetworkProvider _sn;

  Future<String?> get atk async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(kAtkStoreKey);
  }

  UserProvider(BuildContext context) {
    _sn = context.read<SnNetworkProvider>();

    SharedPreferences.getInstance().then((prefs) {
      final value = prefs.getString(kAtkStoreKey);
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
    final resp = await _sn.client.get('/cgi/id/users/me');
    final out = SnAccount.fromJson(resp.data);

    isAuthorized = true;
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
