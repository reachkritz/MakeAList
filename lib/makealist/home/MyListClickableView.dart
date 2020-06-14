import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MyList.dart';
import 'MyListExpandableView.dart';

class MyListClickableView extends StatelessWidget {
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
            width: MediaQuery.of(context).size.width * 0.80,
            child: new Card(
                elevation: 5.0,
                borderOnForeground: true,
                shadowColor: Colors.black12,
                color: Color(0xFFFFD28E),
                child: new MyListCardView(new MyList()))));
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        heroTag: index.toString(),
        shape: RoundedRectangleBorder(),
        elevation: 0.2,
        child: Container(
          alignment: Alignment.center,
          color: Color(0xFFFFD28E),
          child: Text(list.listHeader),
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
