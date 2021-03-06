import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/home/my_drawer.dart';
import 'list.dart';
import 'package:flutter_app_bloc/user_repository/user_repository.dart';

class ListPage extends StatelessWidget {
  ListPage(
      {Key key,
      @required this.title,
      @required this.userRepository,
      @required this.listRepository})
      : super(key: key);
  final String title;
  final UserRepository userRepository;
  final ListRepository listRepository;
  ListBloc listBloc;

  @override
  Widget build(BuildContext context) {
    listBloc = ListBloc(listRepository: listRepository);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: MyDrawer(),
      body: new RefreshIndicator(
        onRefresh: () async {
          listBloc.dispatch(ListCollectionEvent.refresh);
        },
        child: ListCollection(
            listBloc: listBloc, listType: listBloc.listRepository.listType),
      ),
    );
  }
}
