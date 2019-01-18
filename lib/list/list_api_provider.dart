import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'list.dart';

abstract class ListApiProvider<T> {
  Client client = Client();
  final apiKey = 'bb47a09e650e5a1131ffbe13c3141860';
  final String baseEndpoint;

  ListApiProvider(this.baseEndpoint);

  Future<T> retrieveList();
}
