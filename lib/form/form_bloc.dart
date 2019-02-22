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
  final BehaviorSubject<DateTime> _incidentDateController = BehaviorSubject<DateTime>();
  final BehaviorSubject<String> _descriptionController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _reportedByController =
      BehaviorSubject<String>();

  Sink<String> get faultTypeSelected => _faultTypeController.sink;
  Sink<String> get equipmentIDSelected => _equipmentIDController.sink;
  Sink<String> get locationSelected => _locationController.sink;
  Sink<String> get serialNumberChanged => _serialNumberController.sink;
  Sink<DateTime> get incidentDateChanged => _incidentDateController.sink;
  Function(String) get descriptionChanged => _descriptionController.sink.add;
  Function(String) get reportedByChanged => _reportedByController.sink.add;

  Stream<String> get faultType =>
      _faultTypeController.stream.transform(requiredTextValidator);
  Stream<String> get equipmentID =>
      _equipmentIDController.stream.transform(requiredTextValidator);
  Stream<String> get location => _locationController.stream;
  // .transform(requiredTextValidator);
  Stream<String> get serialNumber =>
      _serialNumberController.stream.transform(requiredTextValidator);
  Stream<String> get description =>
      _descriptionController.stream.transform(requiredTextValidator);
  Stream<String> get reportedBy =>
      _reportedByController.stream.transform(requiredTextValidator);

  final _dropDown = BehaviorSubject<String>();
  Stream<String> get dropDownStream => _dropDown.stream;
  Sink<String> get dropDownSink => _dropDown.sink;
  final dropdownValues = [
    '',
    'Inspection',
    'Repair',
    'Replacement',
  ];

  final FormRepository formRepository;
  final EquipmentRepository equipmentRepository;

  FormBloc({this.equipmentRepository, @required this.formRepository})
      : assert(formRepository != null);

  @override
  BaseState get initialState => BaseState.initial();

  @override
  Stream<BaseState> mapEventToState(BaseState currentState, event) async* {
    if (event is SubmitForm) {
      print(_faultTypeController.value);
      print(_locationController.value);
      print(_equipmentIDController.value);
      print(_serialNumberController.value);
      print(_descriptionController.value);
      print(_reportedByController.value);
      yield BaseState.loading();
    }
  }

  @override
  void dispose() {
    _faultTypeController?.close();
    _equipmentIDController?.close();
    _locationController?.close();
    _serialNumberController?.close();
    _incidentDateController?.close();
    _descriptionController?.close();
    _reportedByController?.close();
    _dropDown?.close();
    super.dispose();
  }
}
