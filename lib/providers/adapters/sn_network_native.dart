import 'dart:io';

import 'package:dio/dio.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';

Dio addClientAdapter(Dio client) {
  if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
    // Switch to native implementation if possible
    client.httpClientAdapter = NativeAdapter();
  }
  return client;
}
