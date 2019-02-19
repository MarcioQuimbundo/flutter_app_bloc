import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/home/my_drawer.dart';
import 'package:flutter_app_bloc/list/activity.dart';
import 'package:flutter_app_bloc/list/list.dart';
import 'package:flutter_app_bloc/user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadmore/loadmore.dart';

class ActivityListView extends StatelessWidget {
  const ActivityListView(
      {Key key,
      @required this.title,
      @required this.listBloc})
      : super(key: key);

  final String title;
  final ListBloc listBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListCollectionEvent, ListState>(
      bloc: listBloc,
      builder: (BuildContext context, ListState state) {
        if (state.loadingSucceeded()) {
          List<Activity> activities = state.listItem;
          return SliverList(
              delegate: SliverChildBuilderDelegate((content, index) => makeCard(activities[index]),
                  childCount: activities.length));
          return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: activities.length,
              itemBuilder: (BuildContext context, int index) {
                Activity activity = activities[index];
//                      var widgetVM = _ListWidgetModel(
//                          title: activity.campaignName,
//                          subtitle: activity.nextAction,
//                          rowTitle: activity.status,
//                          rowSubtitle: activity.lastUpdate.toLocal().toString());
                return makeCard(activity);
              });
        } else {
          return SliverToBoxAdapter(
              child: Center(
            child: Text("Loading..."),
          ));
        }
      },
    );
  }

  Widget makeCard(Activity activity) {
    return Card(
      elevation: 1.0,
      child: Container(
        child: makeListTile(activity),
      ),
    );
  }

  Widget makeListTile(Activity activity) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//      leading: Container(
//        padding: EdgeInsets.only(right: 12.0),
//        decoration: BoxDecoration(
//            border: Border(
//                right: BorderSide(width: 1.0, color: Colors.grey))),
//        child: activity != null
//            ? Image.network(
//          activity.iconImage, fit: BoxFit.contain, width: 50.0, height: 50.0,)
//            : Icon(Icons.autorenew, color: Colors.black12),
//        ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            activity.campaignName,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            activity.status,
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600, fontSize: 12),
          ),
          Text(
            activity.status,
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600, fontSize: 12),
            ),
          Text(
            activity.status,
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600, fontSize: 12),
            ),
          Text(
            activity.status,
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600, fontSize: 12),
            ),
        ],
      ),
//      subtitle: Row(
//        children: <Widget>[
//          Expanded(
//              flex: 1,
//              child: Container(
//                // tag: 'hero',
//                child: Text(
//                  "${activity.rowTitle}",
//                  style: TextStyle(color: Colors.black),
//                  ),
//                )),
//          Expanded(
//            flex: 1,
//            child: Container(
//              decoration: BoxDecoration(
//                  border: Border(
//                      left: BorderSide(width: 1.0, color: Colors.black12))),
//              child: Padding(
//                  padding: EdgeInsets.only(left: 10.0),
//                  child: Text(activity.rowSubtitle,
//                                  style: TextStyle(color: Colors.black))),
//              ),
//            )
//        ],
//        ),
      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
      onTap: () {
//        Navigator.of(context).push(MaterialPageRoute(
//            builder: (context) =>
//                EquipmentDetailsPage(title: item.title, id: "1", equipmentRepository: EquipmentRepository(
//                    apiProvider: DVIApiProvider(baseURL))
//                                     )));
//                ListDetailsPage(
//                    title: "${item.title}",
//                    listRepository: EquipmentRepository(
//                        apiProvider: EquipmentListApiProvider(api"https://9134d485-86e7-4fd7-afd5-28500eb1c97d.mock.pstmn.io")
//                        ))));
      },
    );
  }
}
