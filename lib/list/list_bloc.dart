import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'list.dart';
import 'package:rxdart/rxdart.dart';

class ListBloc<T> extends Bloc<ListCollectionEvent, ListState> {
  final ListRepository listRepository;
  final itemController = PublishSubject<T>();

  ListBloc({@required this.listRepository}) : assert(listRepository != null);

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
          T item = await listRepository.fetchList();
          itemController.add(item);
          yield ListState.success(item);
        }
    }
  }
}
