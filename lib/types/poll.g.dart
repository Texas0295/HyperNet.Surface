// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SnPollImpl _$$SnPollImplFromJson(Map<String, dynamic> json) => _$SnPollImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'],
      expiredAt: json['expired_at'],
      options: (json['options'] as List<dynamic>)
          .map((e) => SnPollOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      accountId: (json['account_id'] as num).toInt(),
      metric: SnPollMetric.fromJson(json['metric'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SnPollImplToJson(_$SnPollImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt,
      'expired_at': instance.expiredAt,
      'options': instance.options.map((e) => e.toJson()).toList(),
      'account_id': instance.accountId,
      'metric': instance.metric.toJson(),
    };

_$SnPollMetricImpl _$$SnPollMetricImplFromJson(Map<String, dynamic> json) =>
    _$SnPollMetricImpl(
      totalAnswer: (json['total_answer'] as num).toInt(),
      byOptions: (json['by_options'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      byOptionsPercentage:
          (json['by_options_percentage'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toInt()),
              ) ??
              const {},
    );

Map<String, dynamic> _$$SnPollMetricImplToJson(_$SnPollMetricImpl instance) =>
    <String, dynamic>{
      'total_answer': instance.totalAnswer,
      'by_options': instance.byOptions,
      'by_options_percentage': instance.byOptionsPercentage,
    };

_$SnPollOptionImpl _$$SnPollOptionImplFromJson(Map<String, dynamic> json) =>
    _$SnPollOptionImpl(
      id: json['id'] as String,
      icon: json['icon'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$SnPollOptionImplToJson(_$SnPollOptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'icon': instance.icon,
      'name': instance.name,
      'description': instance.description,
    };
