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
      members: (fields[7] as List).cast<dynamic>(),
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
      'messages': instance.messages,
      'calls': instance.calls,
      'type': instance.type,
      'account_id': instance.accountId,
      'realm': instance.realm?.toJson(),
      'realm_id': instance.realmId,
      'is_public': instance.isPublic,
      'is_community': instance.isCommunity,
    };
