// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Equipments _$EquipmentsFromJson(Map<String, dynamic> json) {
  return Equipments(
      data: (json['data'] as List)
          ?.map((e) =>
      e == null ? null : Equipment.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$EquipmentsToJson(Equipments instance) =>
    <String, dynamic>{'data': instance.data};

Equipment _$EquipmentFromJson(Map<String, dynamic> json) {
  return Equipment(
      id: json['id'] as int,
      name: json['name'] as String,
      itemCode: json['itemCode'] as String,
      installationDate: json['installationDate'] == null
          ? null
          : DateTime.parse(json['installationDate'] as String),
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      warranties: (json['warranties'] as List)
          ?.map((e) =>
      e == null ? null : Warranty.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      attachments:
      (json['attachments'] as List)?.map((e) => e as String)?.toList(),
      serviceHistory: (json['serviceHistory'] as List)
          ?.map((e) =>
      e == null
          ? null
          : ServiceHistory.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$EquipmentToJson(Equipment instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'itemCode': instance.itemCode,
  'installationDate': instance.installationDate?.toIso8601String(),
  'location': instance.location,
  'warranties': instance.warranties,
  'attachments': instance.attachments,
  'serviceHistory': instance.serviceHistory
};

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
      level: json['level'] as String,
      unit: json['unit'] as String,
      placement: json['placement'] as String);
}

Map<String, dynamic> _$LocationToJson(Location instance) =>
    <String, dynamic>{
      'level': instance.level,
      'unit': instance.unit,
      'placement': instance.placement
    };

Warranty _$WarrantyFromJson(Map<String, dynamic> json) {
  return Warranty(
      type: json['type'] as String,
      description: json['description'] as String,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String));
}

Map<String, dynamic> _$WarrantyToJson(Warranty instance) =>
    <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String()
    };
