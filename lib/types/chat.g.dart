// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SnChannelImplAdapter extends TypeAdapter<_$SnChannelImpl> {
  @override
  final int typeId = 2;

  @override
  _$SnChannelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$SnChannelImpl(
      id: fields[0] as int,
      createdAt: fields[1] as DateTime,
      updatedAt: fields[2] as DateTime,
      deletedAt: fields[3] as dynamic,
      alias: fields[4] as String,
      name: fields[5] as String,
      description: fields[6] as String,
      members: (fields[7] as List?)?.cast<dynamic>(),
      type: fields[8] as int,
      accountId: fields[9] as int,
      realm: fields[10] as SnRealm?,
      realmId: fields[11] as int?,
      isPublic: fields[12] as bool,
      isCommunity: fields[13] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, _$SnChannelImpl obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.deletedAt)
      ..writeByte(4)
      ..write(obj.alias)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.type)
      ..writeByte(9)
      ..write(obj.accountId)
      ..writeByte(10)
      ..write(obj.realm)
      ..writeByte(11)
      ..write(obj.realmId)
      ..writeByte(12)
      ..write(obj.isPublic)
      ..writeByte(13)
      ..write(obj.isCommunity)
      ..writeByte(7)
      ..write(obj.members);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnChannelImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SnChannelMemberImplAdapter extends TypeAdapter<_$SnChannelMemberImpl> {
  @override
  final int typeId = 3;

  @override
  _$SnChannelMemberImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$SnChannelMemberImpl(
      id: fields[0] as int,
      createdAt: fields[1] as DateTime,
      updatedAt: fields[2] as DateTime,
      deletedAt: fields[3] as DateTime?,
      channelId: fields[4] as int,
      accountId: fields[5] as int,
      nick: fields[6] as String?,
      channel: fields[7] as SnChannel?,
      account: fields[8] as SnAccount?,
      powerLevel: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$SnChannelMemberImpl obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.deletedAt)
      ..writeByte(4)
      ..write(obj.channelId)
      ..writeByte(5)
      ..write(obj.accountId)
      ..writeByte(6)
      ..write(obj.nick)
      ..writeByte(7)
      ..write(obj.channel)
      ..writeByte(8)
      ..write(obj.account)
      ..writeByte(9)
      ..write(obj.powerLevel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnChannelMemberImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SnChatMessageImplAdapter extends TypeAdapter<_$SnChatMessageImpl> {
  @override
  final int typeId = 4;

  @override
  _$SnChatMessageImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$SnChatMessageImpl(
      id: fields[0] as int,
      createdAt: fields[1] as DateTime,
      updatedAt: fields[2] as DateTime,
      deletedAt: fields[3] as DateTime?,
      uuid: fields[4] as String,
      body: (fields[5] as Map).cast<String, dynamic>(),
      type: fields[6] as String,
      channel: fields[7] as SnChannel,
      sender: fields[8] as SnChannelMember,
      channelId: fields[9] as int,
      senderId: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$SnChatMessageImpl obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.deletedAt)
      ..writeByte(4)
      ..write(obj.uuid)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.channel)
      ..writeByte(8)
      ..write(obj.sender)
      ..writeByte(9)
      ..write(obj.channelId)
      ..writeByte(10)
      ..write(obj.senderId)
      ..writeByte(5)
      ..write(obj.body);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnChatMessageImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      members: json['members'] as List<dynamic>?,
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => SnChatMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      calls: json['calls'],
      type: (json['type'] as num).toInt(),
      accountId: (json['account_id'] as num).toInt(),
      realm: json['realm'] == null
          ? null
          : SnRealm.fromJson(json['realm'] as Map<String, dynamic>),
      realmId: (json['realm_id'] as num?)?.toInt(),
      isPublic: json['is_public'] as bool,
      isCommunity: json['is_community'] as bool,
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
      'messages': instance.messages?.map((e) => e.toJson()).toList(),
      'calls': instance.calls,
      'type': instance.type,
      'account_id': instance.accountId,
      'realm': instance.realm?.toJson(),
      'realm_id': instance.realmId,
      'is_public': instance.isPublic,
      'is_community': instance.isCommunity,
    };

_$SnChannelMemberImpl _$$SnChannelMemberImplFromJson(
        Map<String, dynamic> json) =>
    _$SnChannelMemberImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      channelId: (json['channel_id'] as num).toInt(),
      accountId: (json['account_id'] as num).toInt(),
      nick: json['nick'] as String?,
      channel: json['channel'] == null
          ? null
          : SnChannel.fromJson(json['channel'] as Map<String, dynamic>),
      account: json['account'] == null
          ? null
          : SnAccount.fromJson(json['account'] as Map<String, dynamic>),
      notify: (json['notify'] as num?)?.toInt() ?? 0,
      powerLevel: (json['power_level'] as num).toInt(),
      calls: json['calls'],
      events: json['events'],
    );

Map<String, dynamic> _$$SnChannelMemberImplToJson(
        _$SnChannelMemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'channel_id': instance.channelId,
      'account_id': instance.accountId,
      'nick': instance.nick,
      'channel': instance.channel?.toJson(),
      'account': instance.account?.toJson(),
      'notify': instance.notify,
      'power_level': instance.powerLevel,
      'calls': instance.calls,
      'events': instance.events,
    };

_$SnChatMessageImpl _$$SnChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$SnChatMessageImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      uuid: json['uuid'] as String,
      body: json['body'] as Map<String, dynamic>,
      type: json['type'] as String,
      channel: SnChannel.fromJson(json['channel'] as Map<String, dynamic>),
      sender: SnChannelMember.fromJson(json['sender'] as Map<String, dynamic>),
      channelId: (json['channel_id'] as num).toInt(),
      senderId: (json['sender_id'] as num).toInt(),
      preload: json['preload'] == null
          ? null
          : SnChatMessagePreload.fromJson(
              json['preload'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SnChatMessageImplToJson(_$SnChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'uuid': instance.uuid,
      'body': instance.body,
      'type': instance.type,
      'channel': instance.channel.toJson(),
      'sender': instance.sender.toJson(),
      'channel_id': instance.channelId,
      'sender_id': instance.senderId,
      'preload': instance.preload?.toJson(),
    };

_$SnChatMessagePreloadImpl _$$SnChatMessagePreloadImplFromJson(
        Map<String, dynamic> json) =>
    _$SnChatMessagePreloadImpl(
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : SnAttachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      quoteEvent: json['quote_event'] == null
          ? null
          : SnChatMessage.fromJson(json['quote_event'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SnChatMessagePreloadImplToJson(
        _$SnChatMessagePreloadImpl instance) =>
    <String, dynamic>{
      'attachments': instance.attachments?.map((e) => e?.toJson()).toList(),
      'quote_event': instance.quoteEvent?.toJson(),
    };
