import 'package:flutter_app_bloc/equipment/equipment.dart';
import 'package:meta/meta.dart';
import '../api_provider.dart';

class EquipmentRepository{
  final DVIApiProvider apiProvider;

  EquipmentRepository({@required this.apiProvider});

  Future<List<Equipment>> retrieveEquipmentList() => apiProvider.retrieveEquipmentList();
  Future<Equipment> retrieveEquipment(String id) => apiProvider.retrieveEquipment(id);
  
}