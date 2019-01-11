import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/home/home_page.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
    "/main": (BuildContext context) => new HomePage(),
  };
}
