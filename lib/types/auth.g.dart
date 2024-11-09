// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SnAuthResultImpl _$$SnAuthResultImplFromJson(Map<String, dynamic> json) =>
    _$SnAuthResultImpl(
      isFinished: json['is_finished'] as bool,
      ticket: json['ticket'] == null
          ? null
          : SnAuthTicket.fromJson(json['ticket'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SnAuthResultImplToJson(_$SnAuthResultImpl instance) =>
    <String, dynamic>{
      'is_finished': instance.isFinished,
      'ticket': instance.ticket?.toJson(),
    };

_$SnAuthTicketImpl _$$SnAuthTicketImplFromJson(Map<String, dynamic> json) =>
    _$SnAuthTicketImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      stepRemain: (json['step_remain'] as num).toInt(),
      grantToken: json['grant_token'] as String?,
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      ipAddress: json['ip_address'] as String,
      location: json['location'] as String,
      userAgent: json['user_agent'] as String,
      expiredAt: json['expired_at'] == null
          ? null
          : DateTime.parse(json['expired_at'] as String),
      lastGrantAt: json['last_grant_at'] == null
          ? null
          : DateTime.parse(json['last_grant_at'] as String),
      availableAt: json['available_at'] == null
          ? null
          : DateTime.parse(json['available_at'] as String),
      nonce: json['nonce'] as String?,
      accountId: (json['account_id'] as num?)?.toInt(),
      factorTrail: (json['factor_trail'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$SnAuthTicketImplToJson(_$SnAuthTicketImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'step_remain': instance.stepRemain,
      'grant_token': instance.grantToken,
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'ip_address': instance.ipAddress,
      'location': instance.location,
      'user_agent': instance.userAgent,
      'expired_at': instance.expiredAt?.toIso8601String(),
      'last_grant_at': instance.lastGrantAt?.toIso8601String(),
      'available_at': instance.availableAt?.toIso8601String(),
      'nonce': instance.nonce,
      'account_id': instance.accountId,
      'factor_trail': instance.factorTrail,
    };

_$SnAuthFactorImpl _$$SnAuthFactorImplFromJson(Map<String, dynamic> json) =>
    _$SnAuthFactorImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      type: (json['type'] as num).toInt(),
      config: json['config'] as Map<String, dynamic>?,
      accountId: (json['account_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SnAuthFactorImplToJson(_$SnAuthFactorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'type': instance.type,
      'config': instance.config,
      'account_id': instance.accountId,
    };
