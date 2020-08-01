import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _padding = EdgeInsets.all(5.0);

class Item extends StatefulWidget with ChangeNotifier{
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

  void onChange(){
    notifyListeners();
  }
}

class ItemState extends State<Item>{
  Color rowColor = Colors.white;
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
      widget.itemAction = widget.itemAction == null ? Colors.grey : widget.itemAction;
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
              color: Colors.black54,
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
        width: MediaQuery.of(context).size.width * 0.70,
        color: rowColor,
        child: itemRow
    );
  }

  void _toggleAction() {
    setState(() {
      if (widget.itemAction == Colors.grey) {
        widget.itemAction = Colors.lightGreen;
      } else {
        widget.itemAction = Colors.grey;
      }
    });
    widget.onChange();
  }
}
