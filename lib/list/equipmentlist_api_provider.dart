import 'list_api_provider.dart';
import 'equipment.dart';
export 'equipment.dart';
import 'dart:async';
import 'dart:convert';

class EquipmentListApiProvider extends ListApiProvider {
  EquipmentListApiProvider(String baseEndpoint) : super(baseEndpoint);

  Future<List<Equipment>> retrieveList() async {
    final response =
        await client.get("$baseEndpoint/xrmdev/api/equipments/get");
    if (response.statusCode == 200) {
      return Equipments.fromJson(json.decode(response.body)).data;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
