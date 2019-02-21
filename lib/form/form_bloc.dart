import 'package:flutter_app_bloc/equipment/equipment_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import '../login/validators.dart';
import 'form_respository.dart';
import '../common/common.dart';
import 'form_event.dart';

class FormBloc extends Bloc<BaseEvent, BaseState> with Validators {
  final BehaviorSubject<String> _faultTypeController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _equipmentIDController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _locationController = BehaviorSubject<String>();
  final BehaviorSubject<String> _serialNumberController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _descriptionController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _reportedByController =
      BehaviorSubject<String>();

  Function(String) get faultTypeChanged => _faultTypeController.sink.add;
  Function(String) get equipmentIDChanged => _equipmentIDController.sink.add;
  Function(String) get locationChanged => _locationController.sink.add;
  Function(String) get serialNumberChanged => _serialNumberController.sink.add;
  Function(String) get descriptionChanged => _descriptionController.sink.add;
  Function(String) get reportedByChanged => _reportedByController.sink.add;

  Stream<String> get faultType =>
      _faultTypeController.stream.transform(requiredTextValidator);
  Stream<String> get equipmentID =>
      _equipmentIDController.stream.transform(requiredTextValidator);
  Stream<String> get location =>
      _locationController.stream.transform(requiredTextValidator);
  Stream<String> get serialNumber =>
      _serialNumberController.stream.transform(requiredTextValidator);
  Stream<String> get description =>
      _descriptionController.stream.transform(requiredTextValidator);
  Stream<String> get reportedBy =>
      _reportedByController.stream.transform(requiredTextValidator);

  final FormRepository formRepository;
  final EquipmentRepository equipmentRepository;

  FormBloc({this.equipmentRepository, @required this.formRepository}) :assert(formRepository != null);

  @override
  BaseState get initialState => BaseState.initial();

  @override
  Stream<BaseState> mapEventToState(BaseState currentState, event) async* {
    if (event is SubmitForm) {
      yield BaseState.loading();
    }
  }

  @override
  void dispose() {
    _faultTypeController?.close();
    _equipmentIDController?.close();
    _locationController?.close();
    _serialNumberController?.close();
    _descriptionController?.close();
    _reportedByController?.close();
    super.dispose();
  }

}
