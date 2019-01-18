import 'list_api_provider.dart';
import 'activity.dart';
export 'activity.dart';
import 'dart:async';
import 'dart:convert';

class ActivityListApiProvider extends ListApiProvider {
  ActivityListApiProvider(String baseEndpoint) : super(baseEndpoint);

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
