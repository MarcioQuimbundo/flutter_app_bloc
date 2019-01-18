import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_repository/user_repository.dart';
import 'authentication/authentication.dart';
import 'login/login.dart';
import 'routes.dart';
import 'home/home_page.dart';
import 'list/list.dart';
import 'qr_scanner/qr_scanner.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition.toString());
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  AuthenticationBloc _authenticationBloc;
  final UserRepository _userRepository = UserRepository();
  final ListRepository _listRepository = ListRepository();

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.dispatch(AppStart());
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
        child: MaterialApp(routes: <String, WidgetBuilder>{
          "/": (BuildContext context) {
            return BlocBuilder<AuthenticationEvent, AuthenticationState>(
                bloc: _authenticationBloc,
                builder: (BuildContext context, AuthenticationState state) {
                  List<Widget> widgets = [];
                  if (state.isAuthenticated) {
                    widgets.add(HomePage());
                  } else {
                    widgets.add(LoginPage(
                      userRepository: _userRepository,
                    ));
                  }
                  return Stack(
                    children: widgets,
                  );
                });
          },
          "/main": (BuildContext context) => new HomePage(),
          "/list": (BuildContext context) =>
          new ListPage(
              title: "Equipments",
              userRepository: _userRepository,
              listRepository: _listRepository),
          "/scan": (BuildContext context) => new ScanScreen(),
        }));
  }
}
