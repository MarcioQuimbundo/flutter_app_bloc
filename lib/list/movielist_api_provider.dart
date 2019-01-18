import 'list_api_provider.dart';
import 'item_model.dart';

import 'dart:async';
import 'dart:convert';

class MovieListApiProvider extends ListApiProvider {
  MovieListApiProvider(String baseEndpoint) : super(baseEndpoint);

  Future<ItemModel> retrieveList() async {
    print("entered");
    final response =
        await client.get("$baseEndpoint/3/movie/popular?api_key=$apiKey");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
