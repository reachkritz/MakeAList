import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _padding = EdgeInsets.all(5.0);

class Item extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ItemState();
  }
}

class ItemState extends State<Item> {
  String text;
  Color itemAction = Colors.grey;
  Color rowColor = Color(0xFFFFD28E);

  double _getIconSize() {
    return MediaQuery.of(context).size.height >
            MediaQuery.of(context).size.width
        ? MediaQuery.of(context).size.width * 0.05
        : MediaQuery.of(context).size.height * 0.05;
  }

  void _changeColor() {
    setState(() {
      if(rowColor == Color(0xFFFFD28E)){
        rowColor = Colors.cyan;
      } else {
        rowColor = Color(0xFFFFD28E);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          child: TextField(
            style: TextStyle(
              color: Colors.brown,
              fontSize: 20,
            ),
          ),
        ),
        IconButton(
          hoverColor: Colors.black12,
          focusColor: Colors.blueGrey,
          iconSize: _getIconSize(),
          icon: Icon(
            Icons.check_circle,
            color: itemAction,
          ),
          onPressed: _toggleAction,
        )
      ],
    );

    return Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.55,
        color: rowColor,
        child: itemRow
    );
  }

  void _toggleAction() {
    setState(() {
      if (itemAction == Colors.grey) {
        itemAction = Colors.green;
      } else {
        itemAction = Colors.grey;
      }
    });
  }
}
