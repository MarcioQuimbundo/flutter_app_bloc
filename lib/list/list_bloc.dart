import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'list.dart';
import 'package:rxdart/rxdart.dart';

class ListBloc extends Bloc<ListCollectionEvent, ListState> {
  final ListRepository listRepository;
  final itemController = PublishSubject<ItemModel>();

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
          ItemModel item = await listRepository.fetchList();
          var act = listRepository.retrieveActivities();
          item.results.shuffle();
          yield ListState.success(item);
        }
    }
  }
}
