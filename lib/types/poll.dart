import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll.freezed.dart';
part 'poll.g.dart';

@freezed
class SnPoll with _$SnPoll {
  const factory SnPoll({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required dynamic deletedAt,
    required dynamic expiredAt,
    required List<SnPollOption> options,
    required int accountId,
    required SnPollMetric metric,
  }) = _SnPoll;

  factory SnPoll.fromJson(Map<String, Object?> json) =>
      _$SnPollFromJson(json);
}

@freezed
class SnPollMetric with _$SnPollMetric {
  const factory SnPollMetric({
    required int totalAnswer,
    required dynamic byOptions,
  }) = _SnPollMetric;

  factory SnPollMetric.fromJson(Map<String, Object?> json)
    => _$SnPollMetricFromJson(json);
}

@freezed
class SnPollOption with _$SnPollOption {
  const factory SnPollOption({
    required String id,
    required String icon,
    required String name,
    required String description,
  }) = _SnPollOption;

  factory SnPollOption.fromJson(Map<String, Object?> json)
    => _$SnPollOptionFromJson(json);
}
