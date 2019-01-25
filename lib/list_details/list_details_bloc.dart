import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'list_details_repository.dart';
import '../list/list.dart';

class ListDetailsBloc<T> extends Bloc<ListCollectionEvent, ListState> {
  final ListDetailsRepository listDetailsRepository;
  final itemController = PublishSubject<T>();

  ListDetailsBloc({@required this.listDetailsRepository})
      : assert(listDetailsRepository != null);

  @override
  ListState get initialState => ListState.initial();

  @override
  void dispose() {
    itemController?.close();
  }

  @override
  Stream<ListState> mapEventToState(
      ListState currentState, ListCollectionEvent event) async* {
    switch (event) {
      case ListCollectionEvent.refresh:
        {
          print("refresh");
          yield ListState.loading();
          T item = await listDetailsRepository.fetchItem();
          yield ListState.success(item);
        }
    }
  }
}
