import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';

const kUseLocalNetwork = true;

class SnNetworkProvider {
  late final Dio client;

  SnNetworkProvider() {
    client = Dio();

    client.options.baseUrl = kUseLocalNetwork
        ? 'http://localhost:8001'
        : 'https://api.sn.solsynth.dev';

    client.interceptors.add(RetryInterceptor(
      dio: client,
      retries: 3,
      retryDelays: const [
        Duration(milliseconds: 300),
        Duration(milliseconds: 1000),
        Duration(milliseconds: 3000),
      ],
    ));

    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS || Platform.isMacOS)) {
      // Switch to native implementation if possible
      client.httpClientAdapter = NativeAdapter();
    }
  }

  String getAttachmentUrl(String ky) {
    if (ky.startsWith("http://")) return ky;
    return '${client.options.baseUrl}/cgi/uc/attachments/$ky';
  }
}
