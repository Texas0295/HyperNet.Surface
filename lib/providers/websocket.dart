import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/userinfo.dart';
import 'package:surface/types/websocket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketProvider extends ChangeNotifier {
  bool isBusy = false;
  bool isConnected = false;

  WebSocketChannel? conn;

  late final SnNetworkProvider _sn;
  late final UserProvider _ua;

  StreamController<WebSocketPackage> stream = StreamController.broadcast();

  WebSocketProvider(BuildContext context) {
    _sn = context.read<SnNetworkProvider>();
    _ua = context.read<UserProvider>();

    // Wait for the userinfo provide initialize authorization status
    Future.delayed(const Duration(milliseconds: 250), () async {
      if (_ua.isAuthorized) {
        log('[WebSocket] Connecting to the server...');
        await connect();
      } else {
        log('[WebSocket] Unable connect to the server, unauthorized.');
      }
    });
  }

  Future<void> connect({noRetry = false}) async {
    if (!_ua.isAuthorized) return;
    if (isConnected) {
      disconnect();
    }

    final atk = await _sn.getFreshAtk();
    final uri = Uri.parse(
      '${_sn.client.options.baseUrl.replaceFirst('http', 'ws')}/ws?tk=$atk',
    );

    isBusy = true;
    notifyListeners();

    try {
      conn = WebSocketChannel.connect(uri);
      await conn!.ready;
      log('[WebSocket] Connected to server!');
      isConnected = true;
    } catch (err) {
      if (err is WebSocketChannelException) {
        log('Failed to connect to websocket: ${(err.inner as dynamic).message}');
      } else {
        log('Failed to connect to websocket: $err');
      }

      if (!noRetry) {
        log('Retry connecting to websocket in 3 seconds...');
        return Future.delayed(
          const Duration(seconds: 3),
          () => connect(noRetry: true),
        );
      }
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }

  void disconnect() {
    if (conn != null) {
      conn!.sink.close();
    }
    isConnected = false;
    notifyListeners();
  }

  void listen() {
    conn?.stream.listen(
      (event) {
        final packet = WebSocketPackage.fromJson(jsonDecode(event));
        log('Websocket incoming message: ${packet.method} ${packet.message}');
        stream.sink.add(packet);
        // TODO handle notification
        // if (packet.method == 'notifications.new') {
        //   final NotificationProvider nty = Get.find();
        //   nty.notifications.add(Notification.fromJson(packet.payload!));
        //   nty.notificationUnread.value++;
        // }
      },
      onDone: () {
        isConnected = false;
        notifyListeners();
        Future.delayed(const Duration(seconds: 1), () => connect());
      },
      onError: (err) {
        isConnected = false;
        notifyListeners();
        Future.delayed(const Duration(seconds: 11), () => connect());
      },
    );
  }
}
