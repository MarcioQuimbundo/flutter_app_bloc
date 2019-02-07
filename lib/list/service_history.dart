import 'package:json_annotation/json_annotation.dart';

part 'service_history.g.dart';

@JsonSerializable()
class ServiceHistory {
  int id;
  String equipmentId;
  String serviceNumber;
  String description;
  String responsible;
  String status;
  String remarks;
  DateTime serviceDate;
  DateTime serviceTime;

  ServiceHistory({
    this.id,
    this.equipmentId,
    this.serviceNumber,
    this.description,
    this.responsible,
    this.status,
    this.remarks,
    this.serviceDate,
    this.serviceTime,
  });

  factory ServiceHistory.fromJson(Map<String, dynamic> json) => _$ServiceHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceHistoryToJson(this);
}
