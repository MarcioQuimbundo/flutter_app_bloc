import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/user_repository/user_repository.dart';
import 'list_details_repository.dart';
import 'list_details_bloc.dart';
import 'package:flutter_app_bloc/list_details/widgets/details_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../list/list.dart';
import 'widgets/files_widget.dart';
import '../pdf/pdf_page.dart';

class ListDetailsPage extends StatelessWidget {
  ListDetailsPage(
      {Key key,
      @required this.title,
      this.userRepository,
      @required this.listRepository})
      : super(key: key);
  final String title;
  final UserRepository userRepository;
  final ListDetailsRepository listRepository;
  ListDetailsBloc listDetailsBloc;

  @override
  Widget build(BuildContext context) {
    listDetailsBloc = ListDetailsBloc(listDetailsRepository: listRepository);
    return Container(
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                title: Text(title),
                bottom: TabBar(tabs: [
                  Tab(text: "Details"),
                  Tab(text: "Tasks"),
                  Tab(text: "Files"),
                ]),
              ),
              body: TabBarView(
                children: [
                  BlocProvider(bloc: listDetailsBloc, child: DetailsWidget()),
                  PDFLoadingScreen(),
                  CarouselImage()
                ],
              ))),
    );
    Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocProvider(bloc: listDetailsBloc, child: DetailsWidget()),
    );
  }
}
