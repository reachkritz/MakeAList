import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makealist/makealist/service/FilePersistenceService.dart';
import 'package:makealist/makealist/service/MapPersistenceService.dart';
import 'package:makealist/makealist/service/PersistenceService.dart';

import 'MyList.dart';
import 'MyListCardView.dart';

class MyListClickableView extends StatelessWidget{
  PersistenceService service;
  MyList list;
  int index;
  TextStyle style =
      TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'Raleway');

  MyListClickableView(int index, MyList underlyingList, PersistenceService persistenceService) {
    list = underlyingList;
    this.index = index;
    this.service = persistenceService;
  }

  Widget _showCard(BuildContext context) {
    return new Center(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.80,
            width: MediaQuery.of(context).size.width * 0.85,
            child: Card(
                elevation: 5.0,
                borderOnForeground: true,
                shadowColor: Colors.black12,
                color: Colors.white,
                child: Column(
                  children: [
                    new MyListCardView(list),
                    new ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            color: Colors.blue,
                            child: Text('Delete', style: style),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                            textColor: Colors.white,
                            hoverColor: Colors.cyan,
                            onPressed: () => _deleteList(context),
                          ),
                          FlatButton(
                            color: Colors.blue,
                            child: Text('Update', style: style),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                            textColor: Colors.white,
                            hoverColor: Colors.cyan,
                            onPressed: () => _updateList(context),
                          ),
                          FlatButton(
                            color: Colors.blue,
                            child: Text('Close', style: style),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                            textColor: Colors.white,
                            hoverColor: Colors.cyan,
                            onPressed: () => _closeDialog(context),
                          ),
                        ])
                  ],
                ))));
  }

  void _updateList(BuildContext context) async{
    await service.updateList(list);
    Navigator.of(context).pop();
  }

  void _closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _deleteList(BuildContext context) async{
    await service.deleteList(list);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        heroTag: index.toString(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        elevation: 0.2,
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.4,
          color: Color(0xFFFFE1B0),
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            child: Text(
              list.listHeader,
              style: TextStyle(
                  color: Colors.black, fontSize: 30, fontFamily: 'Raleway'),
            ),
          ),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return _showCard(context);
            },
          );
        });
  }
}
