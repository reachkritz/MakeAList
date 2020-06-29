import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Item.dart';
import 'MyList.dart';

class MyListCardView extends StatefulWidget {
  MyList list;
  @override
  State<StatefulWidget> createState() {
    return MyListCardViewState();
  }

  MyListCardView(MyList underlyingList){
    list = underlyingList;
  }
}

class MyListCardViewState extends State<MyListCardView> {
  List<int> selectedItems = new List();
  final _padding = EdgeInsets.all(5.0);
  TextEditingController _controller = new TextEditingController();
  TextStyle textStyle;
  TextPainter tp ;
  bool firstLoad = true;

  void _setHeader() {
    setState(() {
      widget.list.listHeader = _controller.text;
    });
  }

  double _getIconSize() {
    return MediaQuery.of(context).size.height >
        MediaQuery.of(context).size.width
        ? MediaQuery.of(context).size.width * 0.05
        : MediaQuery.of(context).size.height * 0.05;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    _controller.addListener(_setHeader);
    setState(() {
      _controller.text = widget.list.listHeader;
    });
  }

  TextStyle _changeTextSize(){
    var fieldWidth = MediaQuery.of(context).size.width * 0.80 - 12.0;
    TextSpan ts = new TextSpan(style: textStyle, text: _controller.text);
    tp = new TextPainter(text: ts, textDirection: TextDirection.ltr);
    tp.layout();
    var textWidth = tp.width;
    if(firstLoad){
      setState(() {
        textStyle = TextStyle(
            color: Colors.brown,
            fontSize: 50,
            fontFamily: 'DancingScript');
      });
      firstLoad = false;
    } else {
      if((textWidth - fieldWidth) > 10){
        print(textWidth.toString() + " " + fieldWidth.toString());
        setState(() {
          textStyle = TextStyle(
              color: Colors.brown,
              fontSize: max(textStyle.fontSize - 1, 25),
              fontFamily: 'DancingScript');
        });
      } else if((textWidth - fieldWidth) < -10){
        setState(() {
          textStyle = TextStyle(
              color: Colors.brown,
              fontSize: min(textStyle.fontSize + 1, 50),
              fontFamily: 'DancingScript');
        });
      }
    }}

  @override
  Widget build(BuildContext context) {
    _controller.addListener(_changeTextSize);
    final listView = new Padding(
        padding: EdgeInsets.all(1.0),
        child: Column(
          children: [
            Padding(
                padding: _padding * 2,
                child: TextField(
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black38,
                      maxLength: 50,
                      autofocus: false,
                      maxLengthEnforced: true,
                      controller: _controller,
                      style: textStyle,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(
                              color: Colors.brown,
                              fontSize: 30,
                              fontFamily: 'DancingScript'),
                          labelText: 'Title...'))),
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              width: MediaQuery.of(context).size.width * 0.75,
              child: new ListView.builder(
                  itemCount: widget.list.listItems.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    final item = widget.list.listItems[index];
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      child: Padding(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
                          child: Row(
                            children: [
                              widget.list.listItems[index],
                              IconButton(
                                iconSize: _getIconSize(),
                                icon: Icon(
                                  Icons.delete_forever,
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget.list.removeWithFlags(index);
                                  });
                                },
                              )
                            ],
                          )
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          widget.list.removeWithFlags(index);
                        });
                      },
                    );
                  })
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                size: _getIconSize(),
              ),
              onPressed: () {
                setState(() {
                  widget.list.addWithFlags(new Item.flag(focusFlag: true));
                });
              },
            )
          ]
        ));
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.80,
        height: MediaQuery.of(context).size.height * 0.70,
        child: listView,
      )
    );
  }
}
