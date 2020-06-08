import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _padding = EdgeInsets.all(5.0);

class Item extends StatefulWidget {
  final int index;

  const Item({
    @required this.index,
  }) : assert(index != null);

  @override
  State<StatefulWidget> createState() {
    return new ItemState();
  }
}

class ItemState extends State<Item> {
  String text;
  Color itemAction = Colors.grey;

  @override
  Widget build(BuildContext context) {
    final itemRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          widget.index.toString(),
          style: TextStyle(
            color: Colors.brown,
            fontSize: 20,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.height * 0.5,
          child: TextField(
            style: TextStyle(
              color: Colors.brown,
              fontSize: 20,
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.remove_circle,
            color: Colors.brown,
            size: MediaQuery.of(context).size.height * 0.05,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.check_circle,
            color: itemAction,
            size: MediaQuery.of(context).size.height * 0.05,
          ),
          onPressed: _toggleAction,
        )
      ],
    );

    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.1,
        child: itemRow);
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
