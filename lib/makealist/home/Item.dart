import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _padding = EdgeInsets.all(5.0);

class Item extends StatefulWidget {
  String text;
  bool focusFlag = false;
  Color itemAction;
  Item();
  Item.flag({this.focusFlag});
  Item.text({this.text});
  Item.textFlag({this.text, this.focusFlag});
  @override
  State<StatefulWidget> createState() {
    return new ItemState();
  }
}

class ItemState extends State<Item> {
  Color rowColor = Color(0xFFFFE1B0);
  TextEditingController _controller = new TextEditingController();

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
      widget.itemAction = widget.itemAction == null ? Colors.white : widget.itemAction;
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
          width: MediaQuery.of(context).size.width * 0.60,
          child: TextField(
            controller: _controller,
            autofocus: widget.focusFlag,
            style: TextStyle(
              color: Colors.brown,
              fontSize: 20,
            ),
          ),
        ),
        GestureDetector(
          onTap: _toggleAction,
          child: Icon(
            Icons.check_circle,
            color: widget.itemAction,
          ),
        )
      ],
    );

    return Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.66,
        color: rowColor,
        child: itemRow
    );
  }

  void _toggleAction() {
    setState(() {
      if (widget.itemAction == Colors.white) {
        widget.itemAction = Colors.green;
      } else {
        widget.itemAction = Colors.white;
      }
    });
  }
}
