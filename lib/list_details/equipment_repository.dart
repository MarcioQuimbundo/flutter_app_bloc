import 'package:meta/meta.dart';
import '../api_provider.dart';
import '../list/equipment.dart';

class EquipmentRepository {
  final DVIApiProvider apiProvider;

  EquipmentRepository({@required this.apiProvider});

  Future<Equipment> retrieveEquipment(String id) =>
      apiProvider.retrieveEquipment(id);

  Future<List<Equipment>> retrieveEquipmentList() =>
      apiProvider.retrieveEquipmentList();
}

//abstract class ListDetailsRepositoryAbstract<T> {
//  Future<T> fetchItem();
//}
