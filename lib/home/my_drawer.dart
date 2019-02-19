import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/application.dart';
import 'package:flutter_app_bloc/routes.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
//            DrawerHeader(
//              child: Text(
//                'Drawer Header',
//                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//                ),
//              decoration: BoxDecoration(
//                color: Colors.greenAccent,
//                ),
//              ),
          UserAccountsDrawerHeader(accountName: Text("John Doe"), accountEmail: null),
          ListTile(
            title: Text('Dashboard'),
            leading: Icon(Icons.dashboard),
            onTap: () {
              Navigator.of(context).pop();
              Application.router.navigateTo(context, Routes.root);
            },
          ),
          ListTile(
            title: Text('Equipments'),
            leading: Icon(Icons.devices_other),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.of(context).pop();
              Application.router.navigateTo(context, Routes.equipmentList);
            },
          ),
          ListTile(
            title: Text('Scan QR'),
            leading: Icon(Icons.camera_front),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer

              Navigator.of(context).pop();
              Application.router.navigateTo(context, Routes.scanner);
            },
          ),
          ListTile(
            title: Text('New Case'),
            leading: Icon(Icons.assignment),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.of(context).pop();
              Application.router.navigateTo(context, Routes.note);
            },
          ),
          ListTile(
            title: Text('To Do'),
            leading: Icon(Icons.calendar_today),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.of(context).pop();
              Application.router.navigateTo(context, Routes.todo);
            },
            ),
        ],
      ),
    );
  }
}
