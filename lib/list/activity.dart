import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activities {
  List<Activity> data;

  Activities({
    this.data,
  });

  factory Activities.fromJson(Map<String, dynamic> json) =>
      _$ActivitiesFromJson(json);

  Map<String, dynamic> toJson() => _$ActivitiesToJson(this);
}

class Activity {
  int id;
  int owner;
  String lastAction;
  String nextAction;
  String lastUpdate;
  String campaignName;
  String status;

  Activity({
    this.id,
    this.owner,
    this.lastAction,
    this.nextAction,
    this.lastUpdate,
    this.campaignName,
    this.status,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => new Activity(
        id: json["Id"],
        owner: json["Owner"],
        lastAction: json["LastAction"],
        nextAction: json["NextAction"],
        lastUpdate: json["LastUpdate"],
        campaignName: json["CampaignName"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Owner": owner,
        "LastAction": lastAction,
        "NextAction": nextAction,
        "LastUpdate": lastUpdate,
        "CampaignName": campaignName,
        "Status": status,
      };
}
