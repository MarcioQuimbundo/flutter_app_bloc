import 'package:flutter_app_bloc/list/service_history.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'equipment.g.dart';
//import '../common/base_model.dart';


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
  String itemCode;
  DateTime installationDate;
  Location location;
  List<Warranty> warranties;
  List<String> attachments;
  List<ServiceHistory> serviceHistory;

  Equipment({
    this.id,
    this.name,
    this.itemCode,
    this.installationDate,
    this.location,
    this.warranties,
    this.attachments,
    this.serviceHistory,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) =>
      _$EquipmentFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentToJson(this);

  String formatInstallationDate() =>
      DateFormat('EEE, M/d/y').format(installationDate);


}

@JsonSerializable()
class Location {
  String level;
  String unit;
  String placement;

  Location({
    this.level,
    this.unit,
    this.placement,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }

  String locationPrettyString() {
    List<String> strArr = ["Level: " + level, unit, placement];
    return strArr.join(', ');
  }

}

@JsonSerializable()
class Warranty {
  String type;
  String description;
  DateTime startDate;
  DateTime endDate;

  Warranty({
    this.type,
    this.description,
    this.startDate,
    this.endDate,
  });

  factory Warranty.fromJson(Map<String, dynamic> json) =>
      _$WarrantyFromJson(json);

  Map<String, dynamic> toJson() => _$WarrantyToJson(this);
}
