import 'package:json_annotation/json_annotation.dart';

part 'equipment.g.dart';

@JsonSerializable()
class Equipments {
  List<Equipment> data;

  Equipments({
    this.data,
  });

  factory Equipments.fromJson(Map<String, dynamic> json) =>
      _$EquipmentsFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentsToJson(this);
}

@JsonSerializable()
class Equipment {
  int id;
  String name;
  String serialNumber;
  int quantity;
  int locations;
  String description;

  Equipment({
    this.id,
    this.name,
    this.serialNumber,
    this.quantity,
    this.locations,
    this.description,
  });
}
