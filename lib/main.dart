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

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatefulWidget {
  final UserRepository userRepository = UserRepository();
  Widget defaultHome;

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  AuthenticationBloc _authenticationBloc;

//  final ListRepository _listRepository = ListRepository(
//      listApiProvider: MovieListApiProvider("http://api.themoviedb.org"));

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc(userRepository: widget.userRepository);
    _authenticationBloc.dispatch(AppStart());
    widget.defaultHome = LoginPage(userRepository: widget.userRepository);

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
//            home: LoginPage(userRepository: widget.userRepository),
            routes: <String, WidgetBuilder>{
              "/": (BuildContext context) {
                return BlocBuilder<AuthenticationEvent, AuthenticationState>(
                    bloc: _authenticationBloc,
                    builder: (BuildContext context, AuthenticationState state) {
                      if (state.isAuthenticated) {
                        widget.defaultHome = HomePage();
                      }
                      return widget.defaultHome;
                    });
              },
              "/movie": (BuildContext context) => new ListPage(
                  title: "Movies",
                  userRepository: widget.userRepository,
                  listRepository: ListRepository(
                      listApiProvider: MovieListApiProvider("http://api.themoviedb.org"),
                      listType: SupportedListItems.movie)),
              "/equipment": (BuildContext context) => new ListPage(
                  title: "Equipments",
                  userRepository: widget.userRepository,
                  listRepository: ListRepository(
                      listApiProvider: EquipmentListApiProvider(
                          "https://9134d485-86e7-4fd7-afd5-28500eb1c97d.mock.pstmn.io"),
                      listType: SupportedListItems.equipments)),
              "/scan": (BuildContext context) => new ScanScreen(),
              "/note": (BuildContext context) => new FormPage(),
              "/activity": (BuildContext context) => new ListPage(
                  title: "Activities",
                  userRepository: widget.userRepository,
                  listRepository: ListRepository(
                      listApiProvider: ActivityListApiProvider(
                          "https://9134d485-86e7-4fd7-afd5-28500eb1c97d.mock.pstmn.io"),
                      listType: SupportedListItems.activities)),
            }));
  }
}
