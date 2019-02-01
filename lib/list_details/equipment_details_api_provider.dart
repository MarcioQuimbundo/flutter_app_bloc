import '../list/equipment.dart';
import 'dart:async';
import 'dart:convert';
import '../common/base_api_provider.dart';

class EquipmentListApiProvider extends BaseApiProvider<Equipment> {
  EquipmentListApiProvider(String baseEndpoint) : super(baseEndpoint);

  Future<Equipment> retrieve(String id) async {
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
}
