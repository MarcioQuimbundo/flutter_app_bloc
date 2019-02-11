import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../list/equipment.dart';

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
