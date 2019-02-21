import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_app_bloc/api_provider.dart';
import 'package:flutter_app_bloc/application.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_repository/user_repository.dart';
import 'authentication/authentication.dart';
import 'login/login.dart';
import 'routes.dart';
import 'home/home_page.dart';

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
  final UserRepository userRepository =
      UserRepository(apiProvider: DVIApiProvider(baseURL));

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  AuthenticationBloc _authenticationBloc;
  Widget _defaultHome;

  AppState() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  void initState() {
    _authenticationBloc =
        AuthenticationBloc(userRepository: widget.userRepository);
    _authenticationBloc.dispatch(AppStart());
    _defaultHome = LoginPage(userRepository: widget.userRepository);
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
          theme: ThemeData.fallback(),
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
              bloc: _authenticationBloc,
              builder: (BuildContext context, AuthenticationState state) {
                if (state.isAuthenticated) {
                  _defaultHome = HomePage();
                }
                return _defaultHome;
              }),
          onGenerateRoute: Application.router.generator,
        ));
  }
}
