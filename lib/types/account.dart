import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
class SnAccount with _$SnAccount {
  const SnAccount._();

  const factory SnAccount({
    @HiveField(0) required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? deletedAt,
    required DateTime? confirmedAt,
    required List<SnAccountContact>? contacts,
    required String avatar,
    required String banner,
    required String description,
    required String name,
    required String nick,
    required Map<String, dynamic> permNodes,
    required SnAccountProfile? profile,
    required DateTime? suspendedAt,
    required int? affiliatedId,
    required int? affiliatedTo,
    required int? automatedBy,
    required int? automatedId,
  }) = _SnAccount;

  factory SnAccount.fromJson(Map<String, Object?> json) =>
      _$SnAccountFromJson(json);
}

@freezed
class SnAccountContact with _$SnAccountContact {
  const factory SnAccountContact({
    required int accountId,
    required String content,
    required DateTime createdAt,
    required DateTime? deletedAt,
    required int id,
    required bool isPrimary,
    required bool isPublic,
    required int type,
    required DateTime updatedAt,
    required DateTime? verifiedAt,
  }) = _SnAccountContact;

  factory SnAccountContact.fromJson(Map<String, Object?> json) =>
      _$SnAccountContactFromJson(json);
}

@freezed
class SnAccountProfile with _$SnAccountProfile {
  const factory SnAccountProfile({
    required int id,
    required int accountId,
    required DateTime? birthday,
    required DateTime createdAt,
    required DateTime? deletedAt,
    required int experience,
    required String firstName,
    required String lastName,
    required DateTime? lastSeenAt,
    required DateTime updatedAt,
  }) = _SnAccountProfile;

  factory SnAccountProfile.fromJson(Map<String, Object?> json) =>
      _$SnAccountProfileFromJson(json);
}

@freezed
class SnRelationship with _$SnRelationship {
  const factory SnRelationship({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? deletedAt,
    required int accountId,
    required int relatedId,
    required SnAccount? account,
    required SnAccount? related,
    required int status,
    @Default({}) Map<String, dynamic> permNodes,
  }) = _SnRelationship;

  factory SnRelationship.fromJson(Map<String, Object?> json) =>
      _$SnRelationshipFromJson(json);
}
