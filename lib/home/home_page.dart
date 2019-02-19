import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/api_provider.dart';
import 'package:flutter_app_bloc/application.dart';
import 'package:flutter_app_bloc/home/activity_listview.dart';
import 'package:flutter_app_bloc/home/my_drawer.dart';
import 'package:flutter_app_bloc/list/activity.dart';
import 'package:flutter_app_bloc/list/activitylist_api_provider.dart';
import 'package:flutter_app_bloc/list/equipmentlist_api_provider.dart';
import 'package:flutter_app_bloc/list/list.dart';
import 'package:flutter_app_bloc/qr_scanner/qr_scanner.dart';
import 'package:flutter_app_bloc/routes.dart';
import 'package:flutter_app_bloc/user_repository/user_repository.dart';
import 'diagonal_clipper.dart';
import 'package:flutter/scheduler.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final double _imageHeight = 300.0;
  int _selectedDrawerIndex = 0;
  List<Widget> widg = <Widget>[];
  ScrollController scrollController;
  ListBloc _listBloc;

  @override
  void initState() {
    super.initState();
    _listBloc = ListBloc(
        listRepository: ListRepository(
            listApiProvider: ActivityListApiProvider(baseURL),
            listType: SupportedListItems.activities));
    _listBloc.dispatch(ListCollectionEvent.refresh);
    scrollController = new ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widg = <Widget>[
//      makeDashboardItem("Equipments", Icons.devices_other, '/equipment'),
//      makeDashboardItem("Scan QR", Icons.camera_front, '/scan'),
//      makeDashboardItem("Appointments", Icons.calendar_today, '/activity'),
//      makeDashboardItem("New Case", Icons.assignment, '/note'),
//      makeDashboardItem("Movies", Icons.movie, '/movie'),
//      makeDashboardItem("Settings", Icons.settings, '/'),
    ];

    return Scaffold(
      drawer: MyDrawer(),
      body: Container(color: Colors.white, child: _buildMain()),
      floatingActionButton: FloatingActionButton(
          tooltip: "Start a new case",
          child: Icon(Icons.assignment),
          onPressed: () {
            Application.router.navigateTo(context, Routes.note);
          }),
    );
  }

//  _onSelectItem(int index) {
//    setState(() => _selectedDrawerIndex = index);
//    Navigator.of(context).pop(); // close the drawer
//  }

//  _getDrawerItemWidget(int pos) {
//    switch (pos) {
//      case 0:
//        return _buildMain();
//      case 1:
//        return ListPage(
//            title: "Equipments",
//            userRepository: UserRepository(
//                apiProvider:
//                    DVIApiProvider("https://9134d485-86e7-4fd7-afd5-28500eb1c97d.mock.pstmn.io")),
//            listRepository: ListRepository(
//                listApiProvider: EquipmentListApiProvider(
//                    "https://9134d485-86e7-4fd7-afd5-28500eb1c97d.mock.pstmn.io"),
//                listType: SupportedListItems.equipments));
//      case 2:
//        return ScanScreen();
//
//      default:
//        return new Text("Error");
//    }
//  }

  Widget _buildActions() {
    Widget profile = new GestureDetector(
//      onTap: () => showProfile(),
      child: new Container(
        height: 30.0,
        width: 45.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
          image: new DecorationImage(
            image: new ExactAssetImage("assets/logo.png"),
            fit: BoxFit.cover,
          ),
          border: Border.all(color: Colors.black, width: 2.0),
        ),
      ),
    );

    double scale;
    if (scrollController.hasClients) {
      scale = scrollController.offset / 300;
      scale = scale * 2;
      if (scale > 1) {
        scale = 1.0;
      }
    } else {
      scale = 0.0;
    }

    return new Transform(
      transform: new Matrix4.identity()..scale(scale, scale),
      alignment: Alignment.center,
      child: profile,
    );
  }

  Widget _buildMain() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.orangeAccent,
          expandedHeight: 180.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'images/hearted_tree.jpg',
              fit: BoxFit.fitWidth,
//              fit: BoxFit.contain,
//        height: _imageHeight,
              colorBlendMode: BlendMode.srcOver,
              color: Color.fromARGB(120, 20, 10, 40),
            ),
            title: Text(
              "Good Day Mr. So-so",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
//        _buildImage(),
//        _buildTimeline(),
        _buildList(),
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.of(context).padding.bottom),
        ),
      ],
    );
  }

//  Widget _buildDrawer() {
//    return Drawer(
//      // Add a ListView to the drawer. This ensures the user can scroll
//      // through the options in the Drawer if there isn't enough vertical
//      // space to fit everything.
//      child: ListView(
//        // Important: Remove any padding from the ListView.
//        padding: EdgeInsets.zero,
//        children: <Widget>[
//          UserAccountsDrawerHeader(accountName: Text("John Doe"), accountEmail: null),
////            DrawerHeader(
////              child: Text(
////                'Drawer Header',
////                style: TextStyle(
////                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
////                ),
////              decoration: BoxDecoration(
////                color: Colors.greenAccent,
////                ),
////              ),
//          ListTile(
//            title: Text('Dashboard'),
//            leading: Icon(Icons.dashboard),
//            onTap: () => _onSelectItem(0),
//          ),
//          ListTile(
//            title: Text('Equipments'),
//            leading: Icon(Icons.devices_other),
//            onTap: () {
//              // Update the state of the app
//              // ...
//              // Then close the drawer
//              _onSelectItem(1);
////                Navigator.pop(context);
////                Navigator.pushReplacementNamed(context, '/list');
//            },
//          ),
//          ListTile(
//            title: Text('Scan QR'),
//            leading: Icon(Icons.camera_front),
//            onTap: () {
//              // Update the state of the app
//              // ...
//              // Then close the drawer
//              _onSelectItem(2);
////                Navigator.pushReplacementNamed(context, '/scan');
//            },
//          ),
//          ListTile(
//            title: Text('New Case'),
//            leading: Icon(Icons.assignment),
//            onTap: () {
//              // Update the state of the app
//              // ...
//              Navigator.of(context).push(PageRouteBuilder(
//                  pageBuilder:
//                      (BuildContext context, Animation<double> pri, Animation<double> sec) {},
//                  transitionsBuilder: (context, Animation<double> animation, animation2, Widget child) {
//                    return new FadeTransition(opacity: animation, child: child);
//                  }));
//              // Then close the drawer
//              Navigator.of(context).pop();
//              Navigator.pushReplacementNamed(context, '/note');
////              Navigator.popAndPushNamed(context, '/note');
//            },
//          ),
//        ],
//      ),
//    );
//  }

  Widget _buildImage() {
    return ClipPath(
      clipper: DialogonalClipper(),
      child: Image.asset(
        'images/hearted_tree.jpg',
        fit: BoxFit.contain,
//        height: _imageHeight,
        colorBlendMode: BlendMode.srcOver,
        color: Color.fromARGB(120, 20, 10, 40),
      ),
    );
  }

  Widget _buildTimeline() {
    return new Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 32.0,
      child: new Container(
        width: 1.0,
        color: Colors.grey[300],
      ),
    );
  }

  Widget _buildList() {
    return ActivityListView(title: "activity", listBloc: _listBloc);

//    return SliverList(delegate: SliverChildListDelegate()((BuildContext context, int index) {}));

//    return SliverGrid(
//      delegate: SliverChildBuilderDelegate(
//        (BuildContext context, int index) {
//          return widg[index];
//        },
//        childCount: widg.length,
//      ),
//      gridDelegate:
//          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 25.0),
//    );
  }

  Card makeDashboardItem(String title, IconData icon, String path) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.all(8.0),
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
        child: InkWell(
            onTap: () {
              print(title);
              WidgetsBinding.instance.addPostFrameCallback((_) {
//                Navigator.of(context).pushNamed(path);
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
                Center(
                  child: Text(title, style: TextStyle(fontSize: 15.0, color: Colors.black)),
                )
              ],
            )),
      ),
    );
  }
}
