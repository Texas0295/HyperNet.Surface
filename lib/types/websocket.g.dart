// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WebSocketPackageImpl _$$WebSocketPackageImplFromJson(
        Map<String, dynamic> json) =>
    _$WebSocketPackageImpl(
      method: json['w'] as String? ?? 'unknown',
      endpoint: json['e'] as String?,
      message: json['m'] as String?,
      payload: json['p'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$WebSocketPackageImplToJson(
        _$WebSocketPackageImpl instance) =>
    <String, dynamic>{
      'w': instance.method,
      'e': instance.endpoint,
      'm': instance.message,
      'p': instance.payload,
    };
