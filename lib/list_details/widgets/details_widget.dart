import 'package:flutter/material.dart';
import '../list_details_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsWidget<T extends ListDetailsBloc> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    T bloc = BlocProvider.of<T>(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 56,
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 4,
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                          border: Border(
                              top:
                                  BorderSide(width: 1.0, color: Colors.black26),
                              bottom: BorderSide(
                                  width: 1.0, color: Colors.black26))),
                      // tag: 'hero',
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Due:",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "Mon, Sep 3",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1.0, color: Colors.black26),
                            left: BorderSide(width: 1.0, color: Colors.black26),
                            bottom:
                                BorderSide(width: 1.0, color: Colors.black26))),
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Time left",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12)),
                            SizedBox(height: 5.0),
                            Text(
                              "02:00hrs",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black26))),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, top: 15, right: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 3.0),
                    child: Text("Maintenance type",
                        style: TextStyle(color: Colors.black87, fontSize: 12)),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 4.0, right: 4.0, top: 2.0, bottom: 2.0),
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    child: Text("Inspection",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    padding: EdgeInsets.only(bottom: 3.0),
                    child: Text("Description",
                        style: TextStyle(color: Colors.black87, fontSize: 12)),
                  ),
                  Text(
                      "Check for defects in hydralic controls, may require assistance if there is a huge mess involved. Please advice when necessary.",
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),
                  Container(
                    padding: EdgeInsets.only(bottom: 3.0),
                    child: Text("Assigned to",
                        style: TextStyle(color: Colors.black87, fontSize: 12)),
                  ),
                  Text("Technician A",
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),
                ],
              ),
            ),
          ),
          Container(child: ContactsListPage()),
        ],
      ),
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
//  Contact(name: 'Carson Cupps', email: 'carson.cupps@me.com'),
//  Contact(name: 'Devora Nantz', email: 'devora.nantz@me.com'),
//  Contact(name: 'Tyisha Primus', email: 'tyisha.primus@me.com'),
//  Contact(name: 'Muriel Lewellyn', email: 'muriel.lewellyn@me.com'),
//  Contact(name: 'Hunter Giraud', email: 'hunter.giraud@me.com'),
];
