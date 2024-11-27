import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_in.freezed.dart';
part 'check_in.g.dart';

@freezed
class SnCheckInRecord with _$SnCheckInRecord {
  const SnCheckInRecord._();

  const factory SnCheckInRecord({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? deletedAt,
    required int resultTier,
    required int resultExperience,
    required List<int> resultModifiers,
    required int accountId,
  }) = _SnCheckInRecord;

  factory SnCheckInRecord.fromJson(Map<String, dynamic> json) =>
      _$SnCheckInRecordFromJson(json);

  String get symbol => switch (resultTier) {
        0 => '大凶',
        1 => '凶',
        2 => '中平',
        3 => '吉',
        _ => '大吉',
      };
}
