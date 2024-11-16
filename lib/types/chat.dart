import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:surface/types/realm.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class SnChannel with _$SnChannel {
  const SnChannel._();

  @HiveType(typeId: 2)
  const factory SnChannel({
    @HiveField(0) required int id,
    @HiveField(1) required DateTime createdAt,
    @HiveField(2) required DateTime updatedAt,
    @HiveField(3) required dynamic deletedAt,
    @HiveField(4) required String alias,
    @HiveField(5) required String name,
    @HiveField(6) required String description,
    @HiveField(7) required List<dynamic> members,
    dynamic messages,
    dynamic calls,
    @HiveField(8) required int type,
    @HiveField(9) required int accountId,
    @HiveField(10) required SnRealm? realm,
    @HiveField(11) required int? realmId,
    @HiveField(12) required bool isPublic,
    @HiveField(13) required bool isCommunity,
  }) = _SnChannel;

  factory SnChannel.fromJson(Map<String, dynamic> json) =>
      _$SnChannelFromJson(json);

  String get key => '${realm?.alias ?? 'global'}:$alias';
}
