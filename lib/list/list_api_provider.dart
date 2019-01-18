import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'list.dart';

abstract class ListApiProvider<T> {
  Client client = Client();
  final apiKey = 'bb47a09e650e5a1131ffbe13c3141860';
  final String baseEndpoint;

  ListApiProvider(this.baseEndpoint);

  Future<T> retrieveList() async {
    final b = "https://9134d485-86e7-4fd7-afd5-28500eb1c97d.mock.pstmn.io";
    final response = await client.get("$b/xrmdev/api/activities/get");
    if (response.statusCode == 200) {
//      return Activities.fromJson(json.decode(response.body)).data;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
