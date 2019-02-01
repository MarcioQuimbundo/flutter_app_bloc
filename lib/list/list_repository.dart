import 'package:meta/meta.dart';
import 'list_api_provider.dart';
import 'list.dart';
import '../api_provider.dart';

class ListRepository<T> implements ListRepositoryAbstract {
  final ListApiProvider listApiProvider;
  final SupportedListItems listType;

  ListRepository({@required this.listApiProvider, @required this.listType});

  Future<T> fetchList() => listApiProvider.retrieveList();
}

abstract class ListRepositoryAbstract<T> {
  Future<T> fetchList();
}
