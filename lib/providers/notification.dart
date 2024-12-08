import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/userinfo.dart';

class NotificationProvider extends ChangeNotifier {
  late final SnNetworkProvider _sn;
  late final UserProvider _ua;

  NotificationProvider(BuildContext context) {
    _sn = context.read<SnNetworkProvider>();
    _ua = context.read<UserProvider>();

    // Delay to wait user provider ready to use
    Future.delayed(const Duration(milliseconds: 3000), () async {
      if (!_ua.isAuthorized) return;
      log("Registering push notifications...");
      await registerPushNotifications();
      log("Registered push notification subscriber successfully!");
    });
  }

  Future<void> registerPushNotifications() async {
    if (kIsWeb || Platform.isWindows || Platform.isLinux) return;
    if (!_ua.isAuthorized) return;

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

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
      provider = 'apns';
      token = await FirebaseMessaging.instance.getAPNSToken();
    } else {
      provider = 'fcm';
      token = await FirebaseMessaging.instance.getToken();
    }
    log('Device Push Token is $token');

    await _sn.client.post(
      '/cgi/id/notifications/subscription',
      data: {
        'provider': provider,
        'device_token': token,
        'device_id': deviceUuid,
      },
    );
  }
}
