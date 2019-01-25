import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:meta/meta.dart';
import '../list/list_api_provider.dart';
export '../list/list_api_provider.dart';
import '../list/item_model.dart';

//abstract class ListDetailsApiProvider<T> {
//  Client client = Client();
//  final String baseEndpoint;
//
//  ListDetailsApiProvider(@required this.baseEndpoint);
//
//  Future<T> retrieveItem();
//}

class ListDetailsApiProvider extends ListApiProvider {
  ListDetailsApiProvider(String baseEndpoint) : super(baseEndpoint);

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
