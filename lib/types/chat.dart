import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:surface/types/realm.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class SnChannel with _$SnChannel {
  const factory SnChannel({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required dynamic deletedAt,
    required String alias,
    required String name,
    required String description,
    required List<dynamic> members,
    required dynamic messages,
    required dynamic calls,
    required int type,
    required int accountId,
    required bool isPublic,
    required bool isCommunity,
    required SnRealm? realm,
    required int? realmId,
  }) = _SnChannel;

  factory SnChannel.fromJson(Map<String, dynamic> json) =>
      _$SnChannelFromJson(json);
}
