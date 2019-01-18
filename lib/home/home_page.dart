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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[_buildImage(), _buildGrid()],
      ),
      drawer: new Drawer(),
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
    final widg = <Widget>[
      makeDashboardItem("Equipments", Icons.devices_other),
      makeDashboardItem("Appointments", Icons.calendar_today),
      makeDashboardItem("New Case", Icons.assignment),
      makeDashboardItem("Settings", Icons.settings),
    ];
    return new GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 25.0),
      padding: EdgeInsets.only(
          left: 3.0, top: _imageHeight, right: 3.0, bottom: 3.0),
      itemBuilder: (BuildContext context, int index) {
        return widg[index];
      },
      itemCount: widg.length,
    );
  }

  Card makeDashboardItem(String title, IconData icon) {
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
                Navigator.of(context).pushNamed('/list');
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
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            )),
      ),
    );
  }
}
