import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/api_provider.dart';
import 'package:flutter_app_bloc/form/form_page.dart';
import 'package:flutter_app_bloc/home/home_page.dart';
import 'package:flutter_app_bloc/list/activitylist_api_provider.dart';
import 'package:flutter_app_bloc/list/equipmentlist_api_provider.dart';
import 'package:flutter_app_bloc/list/list.dart';
import 'package:flutter_app_bloc/list/movielist_api_provider.dart';
import 'package:flutter_app_bloc/login/login_page.dart';
import 'package:flutter_app_bloc/qr_scanner/qr_scanner.dart';
import 'package:flutter_app_bloc/user_repository/user_repository.dart';

class Routes {
  static final Map<String, WidgetBuilder> loggedInRoutes = <String, WidgetBuilder>{
//              "/": (BuildContext context) => widget._defaultHome,
    "/movie": (BuildContext context) => ListPage(
        title: "Movies",
        userRepository: UserRepository(
            apiProvider:
                DVIApiProvider("https://9134d485-86e7-4fd7-afd5-28500eb1c97d.mock.pstmn.io")),
        listRepository: ListRepository(
            listApiProvider: MovieListApiProvider("http://api.themoviedb.org"),
            listType: SupportedListItems.movie)),
    "/equipment": (BuildContext context) => ListPage(
        title: "Equipments",
        userRepository: UserRepository(
            apiProvider:
                DVIApiProvider("https://9134d485-86e7-4fd7-afd5-28500eb1c97d.mock.pstmn.io")),
        listRepository: ListRepository(
            listApiProvider: EquipmentListApiProvider(
                "https://9134d485-86e7-4fd7-afd5-28500eb1c97d.mock.pstmn.io"),
            listType: SupportedListItems.equipments)),
    "/scan": (BuildContext context) => new ScanScreen(),
    "/note": (BuildContext context) => new FormPage(),
    "/activity": (BuildContext context) => ListPage(
        title: "Activities",
        userRepository: UserRepository(
            apiProvider:
                DVIApiProvider("https://9134d485-86e7-4fd7-afd5-28500eb1c97d.mock.pstmn.io")),
        listRepository: ListRepository(
            listApiProvider: ActivityListApiProvider(
                "https://9134d485-86e7-4fd7-afd5-28500eb1c97d.mock.pstmn.io"),
            listType: SupportedListItems.activities)),
  };

  static final loggedOutRoutes = <String, WidgetBuilder> {
    "/login": (BuildContext context) => LoginPage()
  };

}
