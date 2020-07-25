import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makealist/makealist/service/PersistorService.dart';

import 'MyList.dart';
import 'MyListCardView.dart';

class MyListClickableView extends StatelessWidget {
  PersistorService service = new PersistorService();
  MyList list;
  int index;

  MyListClickableView(int index, MyList underlyingList) {
    list = underlyingList;
    this.index = index;
  }

  Widget _showCard(BuildContext context) {
    return new Center(
        child: Container(
            height: MediaQuery.of(context).size.height*0.80,
            width: MediaQuery.of(context).size.width*0.80,
            child: new Card(
                elevation: 5.0,
                borderOnForeground: true,
                shadowColor: Colors.black12,
                color: Colors.white,
                child: new MyListCardView(list))));
  }

  void _updateList(){
    service.updateList(list);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        heroTag: index.toString(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
        elevation: 0.2,
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.4,
          color: Color(0xFFFFE1B0),
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            child: Text(
              list.listHeader,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Raleway'),
            ),
          ),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return _showCard(context);
            },
          ).whenComplete(() => _updateList);
        });
  }
}
