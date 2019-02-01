import 'package:http/http.dart' show Client;
import 'list/equipment.dart';
import 'list/activity.dart';
import 'dart:async';
import 'dart:convert';

abstract class BaseApiProvider<T> {
  Client client = Client();
  final String baseEndpoint;

  BaseApiProvider(this.baseEndpoint);
}

class DVIApiProvider extends BaseApiProvider {
  DVIApiProvider(String baseEndpoint) : super(baseEndpoint);

  Future<Equipment> retrieveEquipment(String id) async {
    final response =
        await client.get("$baseEndpoint/xrmdev/api/equipment/${id}/get");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return Equipment.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<List<Equipment>> retrieveEquipmentList() async {
    final response =
        await client.get("$baseEndpoint/xrmdev/api/equipments/get");
    if (response.statusCode == 200) {
      return Equipments.fromJson(json.decode(response.body)).data;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<List<Activity>> retrieveList() async {
    final response =
        await client.get("$baseEndpoint/xrmdev/api/activities/get");
    if (response.statusCode == 200) {
      return Activities.fromJson(json.decode(response.body)).data;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
