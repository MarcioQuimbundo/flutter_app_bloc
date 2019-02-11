// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceHistory _$ServiceHistoryFromJson(Map<String, dynamic> json) {
  return ServiceHistory(
      id: json['id'] as int,
      equipmentId: json['equipmentId'] as String,
      serviceNumber: json['serviceNumber'] as String,
      description: json['description'] as String,
      responsible: json['responsible'] as String,
      status: json['status'] as String,
      remarks: json['remarks'] as String,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      dueTime: json['dueTime'] == null
          ? null
          : DateTime.parse(json['dueTime'] as String),
      serviceDate: json['serviceDate'] == null
          ? null
          : DateTime.parse(json['serviceDate'] as String),
      serviceTime: json['serviceTime'] == null
          ? null
          : DateTime.parse(json['serviceTime'] as String));
}

Map<String, dynamic> _$ServiceHistoryToJson(ServiceHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'equipmentId': instance.equipmentId,
      'serviceNumber': instance.serviceNumber,
      'description': instance.description,
      'responsible': instance.responsible,
      'status': instance.status,
      'remarks': instance.remarks,
      'dueDate': instance.dueDate?.toIso8601String(),
      'dueTime': instance.dueTime?.toIso8601String(),
      'serviceDate': instance.serviceDate?.toIso8601String(),
      'serviceTime': instance.serviceTime?.toIso8601String()
    };
