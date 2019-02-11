import 'package:http/http.dart' show Client;

abstract class BaseApiProvider<T> {
  Client client = Client();
  final String baseEndpoint;

  BaseApiProvider(this.baseEndpoint);
}
