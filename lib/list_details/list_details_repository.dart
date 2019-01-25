import 'package:meta/meta.dart';
import 'list_details_api_provider.dart';

class ListDetailsRepository<T> implements ListDetailsRepositoryAbstract {
  final ListApiProvider listDetailsApiProvider;

//  final SupportedListItems listType;
  ListDetailsRepository({@required this.listDetailsApiProvider});

  Future<T> fetchItem() => listDetailsApiProvider.retrieveList();
}

abstract class ListDetailsRepositoryAbstract<T> {
  Future<T> fetchItem();
}
