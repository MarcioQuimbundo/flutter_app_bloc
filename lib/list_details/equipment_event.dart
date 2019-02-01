import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../list/equipment.dart';

class OperationState<T> {
  final bool isLoading;
  final String error;
  final T item;

  OperationState({this.item, this.error, this.isLoading});

  factory OperationState.initial() {
    return OperationState(isLoading: false, error: '', item: null);
  }

  factory OperationState.loading() {
    return OperationState(isLoading: true);
  }

  factory OperationState.success(T listItem) {
    return OperationState(item: listItem, isLoading: false);
  }

  factory OperationState.failure(String error) {
    return OperationState(error: error, isLoading: false);
  }

  bool loadingSucceeded() => this.item != null;

  bool loadingFailed() => this.error.isNotEmpty;
}

abstract class EquipmentState extends Equatable {
  EquipmentState([List props = const []]) : super(props);
}

class EquipmentRefresh extends EquipmentState {
  @override
  String toString() {
    return 'Refreshing equipment info';
  }
}

class EquipmentLoaded extends EquipmentState {
  Equipment equipment;

  EquipmentLoaded({@required this.equipment}) : super([equipment]);

  @override
  String toString() {
    return 'Refreshing equipment info';
  }
}

/////////////////////
///////EVENTS////////
/////////////////////

abstract class EquipmentEvent extends Equatable {
  EquipmentEvent([List props = const []]) : super(props);
}

class LoadEquipment extends EquipmentEvent {
  String id;

  LoadEquipment({@required this.id}) : super([id]);

  @override
  String toString() {
    return 'Event: Load equipment';
  }
}

class CreateCase extends EquipmentEvent {
  // new case / service history
  @override
  String toString() {
    return "Event: Create a new case";
  }
}
