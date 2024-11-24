import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

const kAtkStoreKey = 'nex_user_atk';
const kRtkStoreKey = 'nex_user_rtk';

const kNetworkServerDefault = 'https://api.sn-next.solsynth.dev';
const kNetworkServerStoreKey = 'app_server_url';

const kNetworkServerDirectory = [
  ('SN Preview', 'https://api.sn-next.solsynth.dev'),
  ('SN Stable', 'https://api.sn.solsynth.dev'),
  ('Local', 'http://localhost:8001'),
];

class SnNetworkProvider {
  late final Dio client;

  late final SharedPreferences _prefs;

  SnNetworkProvider() {
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
          return handler.next(options);
        },
      ),
    );

    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
      client.options.baseUrl =
          _prefs.getString(kNetworkServerStoreKey) ?? kNetworkServerDefault;
    });
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
    client.options.baseUrl = url;
  }
}
