import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/api_provider.dart';
import 'package:flutter_app_bloc/application.dart';
import 'package:flutter_app_bloc/form/form_page.dart';
import 'package:flutter_app_bloc/home/home_page.dart';
import 'package:flutter_app_bloc/list/activitylist_api_provider.dart';
import 'package:flutter_app_bloc/list/equipmentlist_api_provider.dart';
import 'package:flutter_app_bloc/list/list.dart';
import 'package:flutter_app_bloc/list/movielist_api_provider.dart';
import 'package:flutter_app_bloc/login/login_page.dart';
import 'package:flutter_app_bloc/qr_scanner/qr_scanner.dart';
import 'package:flutter_app_bloc/user_repository/user_repository.dart';

import 'package:fluro/fluro.dart';
import 'route_handlers.dart';

class Routes {
  static final Map<String, WidgetBuilder> loggedInRoutes = <String, WidgetBuilder>{
//              "/": (BuildContext context) => widget._defaultHome,
    "/movie": (BuildContext context) => ListPage(
        title: "Movies",
        userRepository: UserRepository(apiProvider: DVIApiProvider(baseURL)),
        listRepository: ListRepository(
            listApiProvider: MovieListApiProvider("http://api.themoviedb.org"),
            listType: SupportedListItems.movie)),
    "/equipment": (BuildContext context) => ListPage(
        title: "Equipments",
        userRepository: UserRepository(apiProvider: DVIApiProvider(baseURL)),
        listRepository: ListRepository(
            listApiProvider: EquipmentListApiProvider(baseURL),
            listType: SupportedListItems.equipments)),
    "/scan": (BuildContext context) => new ScanScreen(),
    "/note": (BuildContext context) => new FormPage(),
    "/activity": (BuildContext context) => ListPage(
        title: "Activities",
        userRepository: UserRepository(apiProvider: DVIApiProvider(baseURL)),
        listRepository: ListRepository(
            listApiProvider: ActivityListApiProvider(baseURL),
            listType: SupportedListItems.activities)),
  };

  static final loggedOutRoutes = <String, WidgetBuilder>{
    "/login": (BuildContext context) => LoginPage()
  };

  static String root = "/";
  static String scanner = "/scan";
  static String note = "/note";
  static String equipmentList = "/equipmentList";
  static String todo = "/todo";

  static void configureRoutes(Router router) {
    router.define(root, handler: rootHandler, transitionType: TransitionType.fadeIn);
    router.define(scanner, handler: scanHandler, transitionType: TransitionType.fadeIn);
    router.define(note, handler: noteHandler, transitionType: TransitionType.nativeModal);
    router.define(equipmentList,
        handler: equipmentListHandler, transitionType: TransitionType.inFromRight);
    router.define(todo, handler: todoHandler, transitionType: TransitionType.fadeIn);
  }
}
