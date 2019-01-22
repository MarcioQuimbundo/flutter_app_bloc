// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Equipments _$EquipmentsFromJson(Map<String, dynamic> json) {
  return Equipments(
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : _$EquipmentFromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$EquipmentsToJson(Equipments instance) =>
    <String, dynamic>{'data': instance.data};

Equipment _$EquipmentFromJson(Map<String, dynamic> json) {
  return Equipment(
      id: json['Id'] as int,
      name: json['Name'] as String,
      serialNumber: json['SerialNumber'] as String,
      quantity: json['Quantity'] as int,
      locations: json['Locations'] as int,
      description: json['Description'] as String);
}

Map<String, dynamic> _$EquipmentToJson(Equipment instance) => <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'SerialNumber': instance.serialNumber,
      'Quantity': instance.quantity,
      'Locations': instance.locations,
      'Description': instance.description
    };
