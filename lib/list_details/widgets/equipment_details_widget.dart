import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/list/equipment.dart';
import 'package:flutter_app_bloc/list_details/equipment_event.dart';
import '../equipment_detail_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

///
/// customize this to fit Equipment's layout
///

class EquipmentDetailsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EquipmentEvent, EquipmentState>(
      bloc: BlocProvider.of<EquipmentDetailBloc>(context),
      builder: (BuildContext context, EquipmentState state) {
        if (state is EquipmentRefresh) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepOrangeAccent,
              strokeWidth: 5.0,
            ),
          );
        } else {
          EquipmentLoaded st = state;
          Equipment equipment = st.equipment;
          return CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    Image.network(equipment.attachments.first,
                        fit: BoxFit.contain),
//                  Container(
//                    height: 56,
//                    child: Row(
//                      children: <Widget>[
//                        Expanded(
//                            flex: 1,
//                            child: Container(
//                              height: 56,
//                              decoration: BoxDecoration(
//                                  border: Border(
//                                      top: BorderSide(
//                                          width: 1.0, color: Colors.black26),
//                                      bottom: BorderSide(
//                                          width: 1.0, color: Colors.black26))),
//                              // tag: 'hero',
//                              child: Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//                                    Text(
//                                      "Due:",
//                                      style: TextStyle(
//                                          color: Colors.black54, fontSize: 12),
//                                    ),
//                                    SizedBox(height: 5.0),
//                                    Text(
//                                      equipment.formatInstallationDate(),
//                                      style: TextStyle(
//                                          color: Colors.black87,
//                                          fontWeight: FontWeight.bold),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            )),
//                        Expanded(
//                          flex: 1,
//                          child: Container(
//                            height: 56,
//                            decoration: BoxDecoration(
//                                border: Border(
//                                    top: BorderSide(
//                                        width: 1.0, color: Colors.black26),
//                                    left: BorderSide(
//                                        width: 1.0, color: Colors.black26),
//                                    bottom: BorderSide(
//                                        width: 1.0, color: Colors.black26))),
//                            child: Padding(
//                                padding: EdgeInsets.all(8.0),
//                                child: Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//                                    Text("Time left",
//                                        style: TextStyle(
//                                            color: Colors.black87, fontSize: 12)),
//                                    SizedBox(height: 5.0),
//                                    Text(
//                                      "02:00hrs",
//                                      style: TextStyle(
//                                          color: Colors.black87,
//                                          fontWeight: FontWeight.bold),
//                                    ),
//                                  ],
//                                )),
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border(
                              top:
                                  BorderSide(width: 1.0, color: Colors.black26),
                              bottom: BorderSide(
                                  width: 1.0, color: Colors.black26))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, top: 15, right: 8, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.only(bottom: 3.0),
//                          child: Text("Maintenance type",
//                              style: TextStyle(
//                                  color: Colors.black87, fontSize: 12)),
//                        ),
//                        Transform(
//                            transform: Matrix4.identity()
//                              ..scale(0.8),
//                            child: Chip(
//                              label: Text("Inspection"),
//                              labelStyle:
//                              TextStyle(color: Colors.white, fontSize: 12),
//                              backgroundColor: Colors.purple,
//                            )),
//                        SizedBox(height: 8.0),
                            _InfoDetailWidget.name(
                                title: "Item Name", text: equipment.name),
                            _InfoDetailWidget.name(
                                title: "Item Code", text: equipment.itemCode),
                            _InfoDetailWidget.name(
                                title: "Installation Date",
                                text: equipment.formatInstallationDate()),
                            _InfoDetailWidget.name(
                                title: "Location",
                                text:
                                    equipment.location.locationPrettyString()),
                            _WarrantyDetailWidget.name(
                                warranties: equipment.warranties),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  Contact contact = allContacts[index];
                  return ContactListTile(contact);
                }, childCount: allContacts.length),
              ),
            ],
          );
        }
      },
    );
  }
}

class _InfoDetailWidget extends StatelessWidget {
  final title;
  final text;

  _InfoDetailWidget.name({this.title, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: TextStyle(color: Colors.black87, fontSize: 12)),
        SizedBox(height: 3.0),
        Text(text,
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
      ],
    );
  }
}

class _WarrantyDetailWidget extends StatelessWidget {
  List<Warranty> warranties;

  _WarrantyDetailWidget.name({this.warranties});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
          children: List.generate(
                  warranties.length,
                  (index) => _InfoDetailWidget.name(
                      title: warranties[index].type,
                      text:
                          "${DateFormat('d MMM yyyy').format(warranties[index].startDate)} to ${DateFormat('d MMM yyyy').format(warranties[index].endDate)}"))
              .toList()),
    );
  }
}

class ContactListTile extends ListTile {
  ContactListTile(Contact contact)
      : super(
          title: Text(contact.name),
          subtitle: Text(contact.email),
          leading: CircleAvatar(child: Text(contact.name[0])),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
        );
}

class ContactsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildList();
  }

  Widget _buildList() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: allContacts.length,
      separatorBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Divider(height: 0.5, color: Colors.black26),
        );
      },
      itemBuilder: (content, index) {
        Contact contact = allContacts[index];
        return ContactListTile(contact);
      },
    );
  }
}

class Contact {
  Contact({this.name, this.email});

  final String name;
  final String email;
}

List<Contact> allContacts = [
  Contact(name: 'Isa Tusa', email: 'isa.tusa@me.com'),
  Contact(name: 'Racquel Ricciardi', email: 'racquel.ricciardi@me.com'),
  Contact(name: 'Teresita Mccubbin', email: 'teresita.mccubbin@me.com'),
  Contact(name: 'Rhoda Hassinger', email: 'rhoda.hassinger@me.com'),
  Contact(name: 'Carson Cupps', email: 'carson.cupps@me.com'),
  Contact(name: 'Devora Nantz', email: 'devora.nantz@me.com'),
  Contact(name: 'Tyisha Primus', email: 'tyisha.primus@me.com'),
  Contact(name: 'Muriel Lewellyn', email: 'muriel.lewellyn@me.com'),
  Contact(name: 'Hunter Giraud', email: 'hunter.giraud@me.com'),
];
