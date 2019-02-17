import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_app_bloc/api_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_repository/user_repository.dart';
import 'authentication/authentication.dart';
import 'login/login.dart';
import 'routes.dart';
import 'home/home_page.dart';
import 'list/list.dart';
import 'qr_scanner/qr_scanner.dart';
import 'form/form_page.dart';
import 'list/movielist_api_provider.dart';
import 'list/activitylist_api_provider.dart';
import 'list/equipmentlist_api_provider.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition.toString());
  }
}

//AuthService appAuth = AuthService();

void main() async {
  BlocSupervisor().delegate = SimpleBlocDelegate();

  runApp(App());
}

class App extends StatefulWidget {
  final UserRepository userRepository = UserRepository(
      apiProvider: DVIApiProvider("https://9134d485-86e7-4fd7-afd5-28500eb1c97d.mock.pstmn.io"));
  Widget _defaultHome;

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  AuthenticationBloc _authenticationBloc;
  Map<String, WidgetBuilder> _routes;

  @override
  void initState() {
//    if (_ready && _result) {
//      widget._defaultHome = widget._home;
//    } else {
//      widget._defaultHome = LoginPage(userRepository: widget.userRepository);
//    }

    _authenticationBloc = AuthenticationBloc(userRepository: widget.userRepository);
    _routes = Routes.loggedOutRoutes;
    _authenticationBloc.dispatch(AppStart());
    widget._defaultHome = LoginPage(userRepository: widget.userRepository);
    super.initState();
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
        bloc: _authenticationBloc,
        child: MaterialApp(
            title: "DVI App",
            debugShowCheckedModeBanner: false,
            home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
                bloc: _authenticationBloc,
                builder: (BuildContext context, AuthenticationState state) {
                  if (state.isAuthenticated) {
                    widget._defaultHome = HomePage();
                    _routes = Routes.loggedInRoutes;
                  }
                  return widget._defaultHome;
                }),
            routes: _routes));
  }
}
