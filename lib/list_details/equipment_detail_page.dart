import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/user_repository/user_repository.dart';
import 'equipment_repository.dart';
import 'equipment_detail_bloc.dart';
import 'equipment_event.dart';
import 'package:flutter_app_bloc/list_details/widgets/equipment_details_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/files_widget.dart';
import '../pdf/pdf_page.dart';

class EquipmentDetailsPage extends StatelessWidget {
  EquipmentDetailsPage(
      {Key key,
      @required this.title,
      @required this.id,
      this.userRepository,
      @required this.equipmentRepository})
      : super(key: key);
  final String title;
  final String id;
  final UserRepository userRepository;
  final EquipmentRepository equipmentRepository;
  EquipmentDetailBloc equipmentDetailBloc;

  @override
  Widget build(BuildContext context) {
    equipmentDetailBloc =
        EquipmentDetailBloc(equipmentRepository: equipmentRepository);
    equipmentDetailBloc.dispatch(LoadEquipment(id: id));
    return BlocProvider(
        bloc: equipmentDetailBloc ??
            EquipmentDetailBloc(equipmentRepository: equipmentRepository),
        child: DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  title: Text(title),
                  bottom: TabBar(tabs: [
                    Tab(text: "Details"),
                    Tab(text: "Tasks"),
                    Tab(text: "Files"),
                  ]),
                ),
                body: TabBarView(
                  children: [
                    EquipmentDetailsWidget(),
                    PDFLoadingScreen(),
                    CarouselImage()
                  ],
                ))));
  }
}
