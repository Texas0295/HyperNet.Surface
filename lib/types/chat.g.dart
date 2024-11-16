// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SnChannelImpl _$$SnChannelImplFromJson(Map<String, dynamic> json) =>
    _$SnChannelImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'],
      alias: json['alias'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      members: json['members'] as List<dynamic>,
      messages: json['messages'],
      calls: json['calls'],
      type: (json['type'] as num).toInt(),
      accountId: (json['account_id'] as num).toInt(),
      isPublic: json['is_public'] as bool,
      isCommunity: json['is_community'] as bool,
      realm: json['realm'] == null
          ? null
          : SnRealm.fromJson(json['realm'] as Map<String, dynamic>),
      realmId: (json['realm_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SnChannelImplToJson(_$SnChannelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt,
      'alias': instance.alias,
      'name': instance.name,
      'description': instance.description,
      'members': instance.members,
      'messages': instance.messages,
      'calls': instance.calls,
      'type': instance.type,
      'account_id': instance.accountId,
      'is_public': instance.isPublic,
      'is_community': instance.isCommunity,
      'realm': instance.realm?.toJson(),
      'realm_id': instance.realmId,
    };
