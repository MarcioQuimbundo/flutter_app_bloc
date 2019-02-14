import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_animation.dart';
import 'components/progress_button.dart';
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

class LoginFormState extends State<LoginForm> with TickerProviderStateMixin {
  AnimationController _loginButtonController;
  Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _loginButtonController =
        new AnimationController(vsync: this, duration: Duration(milliseconds: 3000));
    _buttonAnimation = new CurvedAnimation(parent: _loginButtonController, curve: Curves.easeIn);

    _buttonAnimation.addListener(() => this.setState(() {}));
    _loginButtonController.forward();
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

//  Future<Null> _playAnimation() async {
//    try {
//      await _loginButtonController.forward();
//      await _loginButtonController.reverse();
//    } on TickerCanceled {}
//  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: widget.loginBloc,
      builder: (
        BuildContext context,
        LoginState loginState,
      ) {
        if (loginState.loginSucceeded()) {
          widget.authBloc.dispatch(Login(token: loginState.token));
          widget.loginBloc.dispatch(LoggedIn());
        }

        if (loginState.loginFailed()) {
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
    return SafeArea(
      child: Form(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                StreamBuilder<String>(
                  stream: widget.loginBloc.email,
                  builder: (context, snapshot) => TextField(
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
                  builder: (context, snapshot) => TextField(
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
                StreamBuilder(
                  stream: widget.loginBloc.submitValid,
                  builder: (context, snapshot) => ProgressButton(
                      50.0, loginState, snapshot.hasData ? _onLoginButtonPressed : null),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

//  bool _loginSucceeded(LoginState state) => state.token.isNotEmpty;
//
//  bool _loginFailed(LoginState state) => state.error.isNotEmpty;

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  void _onLoginButtonPressed() {
    widget.loginBloc.dispatch(LoginButtonPressed());
  }
}
