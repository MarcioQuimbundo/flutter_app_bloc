import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'equipment_repository.dart';
import 'equipment_event.dart';

class EquipmentDetailBloc<Equipment>
    extends Bloc<EquipmentEvent, EquipmentState> {
  final EquipmentRepository equipmentRepository;
  final itemController = PublishSubject<Equipment>();

  EquipmentDetailBloc({@required this.equipmentRepository})
      : assert(equipmentRepository != null);

  @override
  EquipmentState get initialState => EquipmentRefresh();

  @override
  void dispose() {
    itemController?.close();
  }

  @override
  Stream<EquipmentState> mapEventToState(EquipmentState currentState,
      EquipmentEvent event) async* {
    if (event is LoadEquipment) {
      yield EquipmentRefresh();
      var equipment = await equipmentRepository.retrieveEquipment(event.id);
      yield EquipmentLoaded(equipment: equipment);
    }
  }
}
