import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/api_provider.dart';
import 'package:flutter_app_bloc/form/form_page.dart';
import 'package:flutter_app_bloc/home/home_page.dart';
import 'package:flutter_app_bloc/list/equipmentlist_api_provider.dart';
import 'package:flutter_app_bloc/list/list.dart';
import 'package:flutter_app_bloc/login/login_page.dart';
import 'package:flutter_app_bloc/qr_scanner/qr_scanner.dart';
import 'package:flutter_app_bloc/todo/todo_page.dart';
import 'package:flutter_app_bloc/user_repository/user_repository.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return HomePage();
    });

var scanHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return ScanScreen();
    });

var noteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return FormPage();
    });

var equipmentListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return ListPage(
          title: "Equipments",
          userRepository: UserRepository(
              apiProvider:
              DVIApiProvider("https://9134d485-86e7-4fd7-afd5-28500eb1c97d.mock.pstmn.io")),
          listRepository: ListRepository(
              listApiProvider: EquipmentListApiProvider(
                  "https://9134d485-86e7-4fd7-afd5-28500eb1c97d.mock.pstmn.io"),
              listType: SupportedListItems.equipments));
    });

var todoHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return ToDoPage();
    });