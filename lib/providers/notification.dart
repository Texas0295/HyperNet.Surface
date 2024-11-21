import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/userinfo.dart';
import 'package:surface/providers/websocket.dart';

class NotificationProvider extends ChangeNotifier {
  late final SnNetworkProvider _sn;
  late final UserProvider _ua;
  late final WebSocketProvider _ws;

  NotificationProvider(BuildContext context) {
    _sn = context.read<SnNetworkProvider>();
    _ua = context.read<UserProvider>();
    _ws = context.read<WebSocketProvider>();
  }

  Future<void> registerPushNotifications() async {
    if (kIsWeb) return;
    if (!_ua.isAuthorized) return;

    late final String? token;
    late final String provider;
    var deviceUuid = await FlutterUdid.consistentUdid;

    if (deviceUuid.isEmpty) {
      log("Unable to active push notifications, couldn't get device uuid");
      return;
    } else {
      log('Device UUID is $deviceUuid');
      log('Registering device push notifications...');
    }

    if (Platform.isIOS || Platform.isMacOS) {
      provider = 'apple';
      token = await FirebaseMessaging.instance.getAPNSToken();
    } else {
      provider = 'firebase';
      token = await FirebaseMessaging.instance.getToken();
    }
    log('Device Push Token is $token');

    await _sn.client.post(
      '/cgi/id/notifications/subscribe',
      data: {
        'provider': provider,
        'device_token': token,
        'device_id': deviceUuid,
      },
    );
  }
}
