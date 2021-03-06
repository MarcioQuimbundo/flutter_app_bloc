import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_app_bloc/user_repository/user_repository.dart';
import 'package:flutter_app_bloc/authentication/authentication.dart';

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository}) : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationState.initializing();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationState currentState, AuthenticationEvent event) async* {
    if (event is AppStart) {
      // attempt to authenticate
      yield currentState.copyWith(isLoading: true);
      await userRepository.authenticate();
      yield AuthenticationState.authenticated();
    }

    if (event is Login) {
      yield currentState.copyWith(isLoading: true);
      await userRepository.persistToken(event.token);
      yield AuthenticationState.authenticated();
    }

    if (event is Logout) {
      yield currentState.copyWith(isLoading: true);
      await userRepository.deleteToken();
      yield AuthenticationState.unauthenticated();
    }
  }
}
