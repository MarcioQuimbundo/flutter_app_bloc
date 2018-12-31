import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app_bloc/authentication/authentication.dart';
import 'login.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthenticationBloc authBloc;

  LoginForm({
    Key key,
    @required this.loginBloc,
    @required this.authBloc,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: widget.loginBloc,
      builder: (BuildContext context,
          LoginState loginState,) {
        if (_loginSucceeded(loginState)) {
          widget.authBloc.dispatch(Login(token: loginState.token));
          widget.loginBloc.dispatch(LoggedIn());
        }

        if (_loginFailed(loginState)) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${loginState.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }
        return _form(loginState);
      },
    );
  }

  Widget _form(LoginState loginState) {
    return Form(
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            StreamBuilder<String>(
              stream: widget.loginBloc.email,
              builder: (context, snapshot) =>
                  TextField(
                    onChanged: widget.loginBloc.emailChanged,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter email",
                        labelText: "Email",
                        errorText: snapshot.error),
                  ),
            ),
            SizedBox(
              height: 20.0,
            ),
            StreamBuilder<String>(
              stream: widget.loginBloc.password,
              builder: (context, snapshot) =>
                  TextField(
                    onChanged: widget.loginBloc.passwordChanged,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter password",
                        labelText: "Password",
                        errorText: snapshot.error),
                  ),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: loginState.isLoginButtonEnabled
                  ? _onLoginButtonPressed
                  : null,
              child: Text('Login'),
            ),
            Container(
              child: loginState.isLoading ? CircularProgressIndicator() : null,
            ),
          ],
        ),
      ),
    );
  }

  bool _loginSucceeded(LoginState state) => state.token.isNotEmpty;

  bool _loginFailed(LoginState state) => state.error.isNotEmpty;

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed() {
    widget.loginBloc.dispatch(LoginButtonPressed());
  }
}
