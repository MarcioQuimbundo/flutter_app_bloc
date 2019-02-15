import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app_bloc/user_repository/user_repository.dart';

import 'package:flutter_app_bloc/authentication/authentication.dart';
import 'login.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = LoginBloc(userRepository: widget.userRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Image.asset(
              'images/dvi-banner image.jpg',
              //              fit: BoxFit.contain,
            ),
            LoginForm(
              authBloc: BlocProvider.of<AuthenticationBloc>(context),
              loginBloc: _loginBloc,
            ),
          ],
        ),
      ),
    );
  }
}
