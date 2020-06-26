import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _padding = EdgeInsets.all(5.0);

class Item extends StatefulWidget {
  String text;
  Item();
  Item.text(String input){
    text = input;
  }
  @override
  State<StatefulWidget> createState() {
    return new ItemState();
  }
}

class ItemState extends State<Item> {
  Color itemAction = Colors.grey;
  Color rowColor = Color(0xFFFFD28E);
  TextEditingController _controller = new TextEditingController();

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

  void _setText() {
    setState(() {
      widget.text = _controller.text;
    });
  }

  @override
  void initState(){
    super.initState();
    _controller.addListener(_setText);
    setState(() {
      _controller.text = widget.text;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final itemRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          child: TextField(
            controller: _controller,
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
