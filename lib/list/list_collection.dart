import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'list.dart';
import 'activity.dart';
import 'equipment.dart';
import '../list_details/list_details_page.dart';
import '../list_details/list_details_repository.dart';
import '../list_details/list_details_api_provider.dart';

class ListCollection extends StatefulWidget {
  final ListBloc listBloc;
  final SupportedListItems listType;

  ListCollection({Key key, @required this.listBloc, @required this.listType})
      : super(key: key);

  @override
  ListCollectionState createState() => new ListCollectionState();
}

class ListCollectionState extends State<ListCollection> {
  @override
  void initState() {
    widget.listBloc.dispatch(ListCollectionEvent.refresh);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    widget.listBloc.dispatch(ListCollectionEvent.refresh);
    return BlocBuilder<ListCollectionEvent, ListState>(
      bloc: widget.listBloc,
      builder: (BuildContext context, ListState state) {
        if (state.loadingSucceeded()) {
          switch (widget.listType) {
            case SupportedListItems.movie:
              {
                ItemModel item = state.listItem;
                return new Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: item.results.length,
                      itemBuilder: (BuildContext context, int index) {
                        Result result = item.results[index];
                        var widgetVM = _ListWidgetModel(
                            title: result.title,
                            subtitle: result.original_title,
                            rowTitle: result.vote_average.toString(),
                            rowSubtitle: result.release_date);
                        return makeCard(widgetVM);
                      }),
                );
              }
            case SupportedListItems.activities:
              {
                List<Activity> activities = state.listItem;
                return new Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: activities.length,
                      itemBuilder: (BuildContext context, int index) {
                        Activity activity = activities[index];
                        var widgetVM = _ListWidgetModel(
                            title: activity.campaignName,
                            subtitle: activity.nextAction,
                            rowTitle: activity.status,
                            rowSubtitle:
                            activity.lastUpdate.toLocal().toString());
                        return makeCard(widgetVM);
                      }),
                );
              }
            case SupportedListItems.equipments:
              {
                List<Equipment> equipments = state.listItem;
                return new Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: equipments.length,
                      itemBuilder: (BuildContext context, int index) {
                        Equipment equip = equipments[index];
                        var widgetVM = _ListWidgetModel(
                            title: equip.name,
                            subtitle: equip.description,
                            rowTitle: equip.serialNumber,
                            rowSubtitle: equip.description);
                        return makeCard(widgetVM);
                      }),
                );
              }
          }
        } else {
          return new Container(
            height: 0,
            width: 0,
          );
        }
      },
    );

////    return ListView.builder(itemBuilder: (BuildContext context, int index) {
////      listRepository.
////    });
//    return ListView.builder(
//        itemCount: allContacts.length,
//        itemBuilder: (BuildContext content, int index) {
//          Contact contact = allContacts[index];
//          return ContactListTile(contact);
//        });
  }

  Widget makeCard(_ListWidgetModel item) {
    return Card(
      elevation: 1.0,
//      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
//        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .4)),
        child: makeListTile(item),
      ),
    );
  }

  Widget makeListTile(_ListWidgetModel item) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.grey))),
        child: Icon(Icons.autorenew, color: Colors.black12),
      ),
      title: Text(
        item.title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: <Widget>[
          Expanded(
              flex: 4,
              child: Container(
                // tag: 'hero',
                child: Text(
                  "${item.rowTitle}",
                  style: TextStyle(color: Colors.black),
                ),
              )),
          Expanded(
            flex: 4,
            child: Container(
              decoration: new BoxDecoration(
                  border: new Border(
                      left: new BorderSide(width: 1.0, color: Colors.black12))),
              child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(item.rowSubtitle,
                      style: TextStyle(color: Colors.black))),
            ),
          )
        ],
      ),
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ListDetailsPage(
                    title: "${item.title}",
                    listRepository: ListDetailsRepository(
                        listDetailsApiProvider: new ListDetailsApiProvider(
                            "https://9134d485-86e7-4fd7-afd5-28500eb1c97d.mock.pstmn.io")))));
      },
    );
  }
}

class _ListWidgetModel {
  String title;
  String subtitle;
  String rowTitle;
  String rowSubtitle;

  _ListWidgetModel(
      {this.title, this.subtitle, this.rowTitle, this.rowSubtitle});
}
