import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'list.dart';

class ListCollection extends StatefulWidget {
  final ListBloc listBloc;

  ListCollection({
    Key key,
    @required this.listBloc,
  }) : super(key: key);

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
          ItemModel listItem = state.listItem;
          return new Container(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: listItem.results.length,
                itemBuilder: (BuildContext context, int index) {
                  return makeCard(listItem.results[index]);
                }),
          );
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

  Widget makeCard(Result item) {
    return Card(
      elevation: 1.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
//        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .4)),
        child: makeListTile(item),
      ),
    );
  }

  Widget makeListTile(Result item) {
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
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  // tag: 'hero',
                  child: Text(
                    "${item.vote_average}",
                    style: TextStyle(color: Colors.black),
                  ),
                )),
            Expanded(
              flex: 4,
              child: Container(
                decoration: new BoxDecoration(
                    border: new Border(
                        left:
                        new BorderSide(width: 1.0, color: Colors.black12))),
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(item.release_date,
                        style: TextStyle(color: Colors.black))),
              ),
            )
          ],
        ),
        trailing:
        Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0));
  }
}
