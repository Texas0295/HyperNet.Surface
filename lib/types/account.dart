import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
abstract class SnAccount with _$SnAccount {
  const SnAccount._();

  const factory SnAccount({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? deletedAt,
    required DateTime? confirmedAt,
    required List<SnAccountContact>? contacts,
    @Default("") String avatar,
    @Default("") String banner,
    required String name,
    required String nick,
    @Default({}) Map<String, dynamic> permNodes,
    required String language,
    required SnAccountProfile? profile,
    @Default([]) List<SnAccountBadge> badges,
    @Default([]) List<SnPunishment> punishments,
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
abstract class SnAccountContact with _$SnAccountContact {
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
abstract class SnAccountProfile with _$SnAccountProfile {
  const factory SnAccountProfile({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? deletedAt,
    required String firstName,
    required String lastName,
    required String description,
    required String timeZone,
    required String location,
    required String pronouns,
    required String gender,
    @Default({}) Map<String, String> links,
    required int experience,
    required DateTime? lastSeenAt,
    required DateTime? birthday,
    required int accountId,
  }) = _SnAccountProfile;

  factory SnAccountProfile.fromJson(Map<String, Object?> json) =>
      _$SnAccountProfileFromJson(json);
}

@freezed
abstract class SnRelationship with _$SnRelationship {
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

@freezed
abstract class SnAccountBadge with _$SnAccountBadge {
  const factory SnAccountBadge({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required dynamic deletedAt,
    required String type,
    required int accountId,
    @Default(false) bool isActive,
    @Default({}) Map<String, dynamic> metadata,
  }) = _SnAccountBadge;

  factory SnAccountBadge.fromJson(Map<String, Object?> json) =>
      _$SnAccountBadgeFromJson(json);
}

@freezed
abstract class SnAccountStatusInfo with _$SnAccountStatusInfo {
  const factory SnAccountStatusInfo({
    required bool isDisturbable,
    required bool isOnline,
    required DateTime? lastSeenAt,
    required SnAccountStatus? status,
  }) = _SnAccountStatusInfo;

  factory SnAccountStatusInfo.fromJson(Map<String, Object?> json) =>
      _$SnAccountStatusInfoFromJson(json);
}

@freezed
abstract class SnAccountStatus with _$SnAccountStatus {
  const factory SnAccountStatus({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? deletedAt,
    required String type,
    required String label,
    required int attitude,
    required bool isNoDisturb,
    required bool isInvisible,
    required DateTime? clearAt,
    required int accountId,
  }) = _SnAccountStatus;

  factory SnAccountStatus.fromJson(Map<String, Object?> json) =>
      _$SnAccountStatusFromJson(json);
}

@freezed
abstract class SnAbuseReport with _$SnAbuseReport {
  const factory SnAbuseReport({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? deletedAt,
    required String resource,
    required String reason,
    required String status,
    required int accountId,
  }) = _SnAbuseReport;

  factory SnAbuseReport.fromJson(Map<String, Object?> json) =>
      _$SnAbuseReportFromJson(json);
}

@freezed
abstract class SnActionEvent with _$SnActionEvent {
  const factory SnActionEvent({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? deletedAt,
    required String type,
    required Map<String, dynamic>? metadata,
    required String? location,
    required double? coordinateX,
    required double? coordinateY,
    required String ipAddress,
    required String userAgent,
    required SnAccount account,
    required int accountId,
  }) = _SnActionEvent;

  factory SnActionEvent.fromJson(Map<String, Object?> json) =>
      _$SnActionEventFromJson(json);
}

@freezed
abstract class SnProgram with _$SnProgram {
  const factory SnProgram({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? deletedAt,
    required String name,
    required String description,
    required String alias,
    required int expRequirement,
    required Map<String, dynamic> price,
    required Map<String, dynamic> badge,
    required Map<String, dynamic> group,
    required Map<String, dynamic> appearance,
  }) = _SnProgram;

  factory SnProgram.fromJson(Map<String, Object?> json) =>
      _$SnProgramFromJson(json);
}

@freezed
abstract class SnProgramMember with _$SnProgramMember {
  const factory SnProgramMember({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? deletedAt,
    required DateTime lastPaid,
    required SnAccount account,
    required int accountId,
    required SnProgram program,
    required int programId,
  }) = _SnProgramMember;

  factory SnProgramMember.fromJson(Map<String, Object?> json) =>
      _$SnProgramMemberFromJson(json);
}

@freezed
abstract class SnPunishment with _$SnPunishment {
  const factory SnPunishment({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? deletedAt,
    required String reason,
    required int type,
    @Default({}) Map<String, dynamic> permNodes,
    required DateTime? expiredAt,
    required SnAccount? account,
    required int? accountId,
    required SnAccount? moderator,
    required int? moderatorId,
  }) = _SnPunishment;

  factory SnPunishment.fromJson(Map<String, Object?> json) =>
      _$SnPunishmentFromJson(json);
}
