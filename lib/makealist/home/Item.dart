import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';

class Item extends StatefulWidget with ChangeNotifier{
  GlobalKey<FormState> formKey;
  String text;
  bool focusFlag = false;
  int actionCode;
  Item();
  Item.flag({this.focusFlag});
  Item.text({this.text});
  Item.textFlag({this.text, this.focusFlag});

  Item.fromJson(Map<String, dynamic> json)
  : text = json['text'], actionCode = json['actionCode'], focusFlag = true;

  @override
  State<StatefulWidget> createState() {
    return ItemState();
  }

  void onChange(){
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'actionCode': actionCode,
    };
  }
}

class ItemState extends State<Item>{
  Color rowColor = Colors.white;
  TextEditingController _controller = new TextEditingController();

  void _setText() {
    if(widget.text != _controller.text){
      setState(() {
        widget.text = _controller.text;
      });
    }
  }

  @override
  void initState(){
    super.initState();
    _controller.addListener(_setText);
    setState(() {
      _controller.text = widget.text;
      //below ensures that the cursor always appears at the end of current text
      _controller.selection = TextSelection.collapsed(offset: widget.text == null ? 0 : widget.text.length);
      widget.actionCode = widget.actionCode == null ? 0 : widget.actionCode;
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
          child: AutoSizeTextField(
            cursorColor: Colors.lightBlueAccent,
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
            color: _getActionColor(widget.actionCode),
          ),
        )
      ],
    );

    return Container(
        key: widget.formKey,
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.70,
        color: rowColor,
        child: itemRow
    );
  }

  Color _getActionColor(int actionCode){
    if(actionCode==0) return Colors.grey;
    else return Colors.lightGreen;
  }

  void _toggleAction() {
    setState(() {
      if (widget.actionCode == 0) {
        widget.actionCode = 1;
      } else {
        widget.actionCode = 0;
      }
    });
    widget.onChange();
  }
}
