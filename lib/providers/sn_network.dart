import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surface/providers/config.dart';
import 'package:surface/providers/widget.dart';
import 'package:synchronized/synchronized.dart';

const kNetworkServerDirectory = [
  ('Solar Network', 'https://api.sn.solsynth.dev'),
  ('Local', 'http://localhost:8001'),
];

class SnNetworkProvider {
  late final Dio client;

  late final SharedPreferences _prefs;
  late final ConfigProvider _config;
  late final HomeWidgetProvider _home;

  String? _userAgent;

  SnNetworkProvider(BuildContext context) {
    _home = context.read<HomeWidgetProvider>();

    client = Dio();

    client.interceptors.add(RetryInterceptor(
      dio: client,
      retries: 3,
      retryDelays: const [
        Duration(milliseconds: 300),
        Duration(milliseconds: 1000),
        Duration(milliseconds: 3000),
      ],
    ));

    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (
          RequestOptions options,
          RequestInterceptorHandler handler,
        ) async {
          final atk = await getFreshAtk();
          if (atk != null) {
            options.headers['Authorization'] = 'Bearer $atk';
          }
          if (_userAgent != null) {
            options.headers['User-Agent'] = _userAgent!;
          }
          return handler.next(options);
        },
      ),
    );

    _config = context.read<ConfigProvider>();
    _config.initialize().then((_) {
      _prefs = _config.prefs;
      client.options.baseUrl = _config.serverUrl;
      if (!context.mounted) return;
      _home.saveWidgetData("nex_server_url", client.options.baseUrl);
    });
  }

  static Future<Dio> createOffContextClient() async {
    final prefs = await SharedPreferences.getInstance();
    final client = Dio();
    client.interceptors.add(RetryInterceptor(
      dio: client,
      retries: 3,
      retryDelays: const [
        Duration(milliseconds: 300),
        Duration(milliseconds: 1000),
        Duration(milliseconds: 3000),
      ],
    ));
    final ua = await _getUserAgent();
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (
          RequestOptions options,
          RequestInterceptorHandler handler,
        ) async {
          options.headers['User-Agent'] = ua;
          return handler.next(options);
        },
      ),
    );
    client.options.baseUrl = prefs.getString(kNetworkServerStoreKey) ?? kNetworkServerDefault;

    return client;
  }

  static Future<String> _getUserAgent() async {
    final String platformInfo;
    if (kIsWeb) {
      final deviceInfo = await DeviceInfoPlugin().webBrowserInfo;
      platformInfo = 'Web; ${deviceInfo.vendor}';
    } else if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      platformInfo = 'Android; ${deviceInfo.brand} ${deviceInfo.model}; ${deviceInfo.id}';
    } else if (Platform.isIOS) {
      final deviceInfo = await DeviceInfoPlugin().iosInfo;
      platformInfo = 'iOS; ${deviceInfo.model}; ${deviceInfo.name}';
    } else if (Platform.isMacOS) {
      final deviceInfo = await DeviceInfoPlugin().macOsInfo;
      platformInfo = 'MacOS; ${deviceInfo.model}; ${deviceInfo.hostName}';
    } else if (Platform.isWindows) {
      final deviceInfo = await DeviceInfoPlugin().windowsInfo;
      platformInfo = 'Windows NT; ${deviceInfo.productName}; ${deviceInfo.computerName}';
    } else if (Platform.isLinux) {
      final deviceInfo = await DeviceInfoPlugin().linuxInfo;
      platformInfo = 'Linux; ${deviceInfo.prettyName}';
    } else {
      platformInfo = 'Unknown';
    }

    final packageInfo = await PackageInfo.fromPlatform();

    return 'Solian/${packageInfo.version}+${packageInfo.buildNumber} ($platformInfo)';
  }

  Future<void> initializeUserAgent() async {
    _userAgent = await _getUserAgent();
  }

  final tkLock = Lock();

  Completer<String?>? _refreshCompleter;

  Future<String?> getFreshAtk() async {
    if (_refreshCompleter != null) {
      return await _refreshCompleter!.future;
    } else {
      _refreshCompleter = Completer<String?>();
    }

    try {
      var atk = _prefs.getString(kAtkStoreKey);
      if (atk != null) {
        final atkParts = atk.split('.');
        if (atkParts.length != 3) {
          throw Exception('invalid format of access token');
        }

        var rawPayload = atkParts[1].replaceAll('-', '+').replaceAll('_', '/');
        switch (rawPayload.length % 4) {
          case 0:
            break;
          case 2:
            rawPayload += '==';
            break;
          case 3:
            rawPayload += '=';
            break;
          default:
            throw Exception('illegal format of access token payload');
        }

        final b64 = utf8.fuse(base64Url);
        final payload = b64.decode(rawPayload);
        final exp = jsonDecode(payload)['exp'];
        if (exp <= DateTime.now().millisecondsSinceEpoch ~/ 1000) {
          log('Access token need refresh, doing it at ${DateTime.now()}');
          atk = await refreshToken();
        }

        if (atk != null) {
          _refreshCompleter!.complete(atk);
          return atk;
        } else {
          log('Access token refresh failed...');
          _refreshCompleter!.complete(null);
        }
      }
    } catch (err) {
      log('Failed to authenticate user: $err');
      _refreshCompleter!.completeError(err);
    } finally {
      _refreshCompleter = null;
    }

    return null;
  }

  String getAttachmentUrl(String ky) {
    if (ky.startsWith("http")) return ky;
    return '${client.options.baseUrl}/cgi/uc/attachments/$ky';
  }

  void setTokenPair(String atk, String rtk) {
    _prefs.setString(kAtkStoreKey, atk);
    _prefs.setString(kRtkStoreKey, rtk);
  }

  void clearTokenPair() {
    _prefs.remove(kAtkStoreKey);
    _prefs.remove(kRtkStoreKey);
  }

  Future<String?> refreshToken() async {
    final rtk = _prefs.getString(kRtkStoreKey);
    if (rtk == null) return null;

    final dio = Dio();
    dio.options.baseUrl = client.options.baseUrl;

    final resp = await dio.post('/cgi/id/auth/token', data: {
      'grant_type': 'refresh_token',
      'refresh_token': rtk,
    });

    final atk = resp.data['access_token'];
    final nRtk = resp.data['refresh_token'];
    setTokenPair(atk, nRtk);

    return atk;
  }

  void setBaseUrl(String url) {
    _config.serverUrl = url;
    client.options.baseUrl = url;
  }
}
