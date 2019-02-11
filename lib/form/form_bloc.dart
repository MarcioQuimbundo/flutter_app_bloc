import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import '../login/validators.dart';
import 'form_respository.dart';
import '../common/common.dart';
import 'form_event.dart';

class FormBloc extends Bloc<BaseEvent, BaseState> with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();
  final _signupController = PublishSubject<Map<String, dynamic>>();
  final FormRepository _repository = FormRepository();

  @override
  BaseState get initialState => BaseState.initial();

  @override
  Stream<BaseState> mapEventToState(BaseState currentState, event) async* {
    // TODO: implement mapEventToState
    if (event is SubmitForm) {
      yield BaseState.loading();
    }

  }

}
