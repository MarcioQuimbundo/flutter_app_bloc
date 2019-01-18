// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activities _$ActivitiesFromJson(Map<String, dynamic> json) {
  return Activities(
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Activity.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ActivitiesToJson(Activities instance) =>
    <String, dynamic>{'data': instance.data};
