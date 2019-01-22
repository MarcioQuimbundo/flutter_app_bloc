import 'package:flutter/material.dart';
import 'diagonal_clipper.dart';
import 'package:flutter/scheduler.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _imageHeight = 300.0;
  List<Widget> widg = <Widget>[];

  @override
  Widget build(BuildContext context) {
    widg = <Widget>[
      makeDashboardItem("Equipments", Icons.devices_other, '/equipment'),
      makeDashboardItem("Scan QR", Icons.camera_front, '/scan'),
      makeDashboardItem("Appointments", Icons.calendar_today, '/activity'),
      makeDashboardItem("New Case", Icons.assignment, '/note'),
      makeDashboardItem("Movies", Icons.movie, '/movie'),
      makeDashboardItem("Settings", Icons.settings, '/'),
    ];

    return Scaffold(
      drawer: new Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Drawer Header',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Equipments'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/list');
              },
            ),
            ListTile(
              title: Text('Scan QR'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacementNamed(context, '/scan');
              },
            ),
            ListTile(
              title: Text('New Case'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.popAndPushNamed(context, '/note');
              },
            ),
          ],
        ),
      ),
      body: new CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.grey,
            expandedHeight: 120.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Home"),
            ),
          ),
//        _buildImage(),
          _buildGrid(),
        ],
      ),
    );

    return new Scaffold(
      body: new Stack(
        children: <Widget>[_buildImage(), _buildGrid()],
      ),
      drawer: new Drawer(
        semanticLabel: "Text",
      ),
    );
  }

  Widget _buildImage() {
    return new ClipPath(
      clipper: new DialogonalClipper(),
      child: new Image.asset(
        'images/hearted_tree.jpg',
        fit: BoxFit.contain,
//        height: _imageHeight,
        colorBlendMode: BlendMode.srcOver,
        color: new Color.fromARGB(120, 20, 10, 40),
      ),
    );
  }

  Widget _buildGrid() {
    return new SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return widg[index];
        },
        childCount: widg.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 25.0),
    );
//    return new GridView.builder(
//      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//          crossAxisCount: 3, mainAxisSpacing: 25.0),
//      padding:
//          EdgeInsets.only(left: 3.0, top: 747.0, right: 3.0, bottom: 3.0),
//      itemBuilder: (BuildContext context, int index) {
//        return widg[index];
//      },
//      itemCount: widg.length,
//    );
  }

  Card makeDashboardItem(String title, IconData icon, String path) {
    return Card(
      elevation: 1.0,
      margin: new EdgeInsets.all(8.0),
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
        child: new InkWell(
            onTap: () {
              print(title);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushNamed(path);
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 20.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                      new TextStyle(fontSize: 15.0, color: Colors.black)),
                )
              ],
            )),
      ),
    );
  }
}
