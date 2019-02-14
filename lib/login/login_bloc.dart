import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'validators.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_app_bloc/user_repository/user_repository.dart';
import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with Validators {
  final UserRepository userRepository;
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Function(String) get emailChanged => _emailController.sink.add;

  Function(String) get passwordChanged => _passwordController.sink.add;

  Stream<String> get email => _emailController.stream.transform(emailValidator);

  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);

  Stream<bool> get submitValid => Observable.combineLatest2(email, password, (e,p) => true);

  LoginBloc({@required this.userRepository}) : assert(userRepository != null);

  @override
  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(
      LoginState currentState, LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginState.loading();

      try {
        final token = await userRepository.authenticate(
            username: _emailController.value,
            password: _passwordController.value);
        yield LoginState.success(token);
      } catch (error) {
        yield LoginState.failure(error.toString());
      }
    }

    if (event is LoggedIn) {
//      yield LoginState.initial();
    }
  }

  @override
  void dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
