import 'dart:async';
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

  MyListCardView(MyList underlyingList) {
    list = underlyingList;
  }
}

class MyListCardViewState extends State<MyListCardView> {
  List<int> selectedItems = new List();
  final _padding = EdgeInsets.all(5.0);
  TextEditingController _controller = new TextEditingController();
  TextStyle textStyle = TextStyle(
      color: Colors.brown,
      fontSize: 50,
      fontFamily: 'DancingScript');
  TextPainter tp;

  bool overflowFlag = false;
  bool underflowFlag = false;

  void _setHeader() {
    widget.list.listHeader = _controller.text;
  }

  double _getIconSize() {
    return MediaQuery
        .of(context)
        .size
        .height >
        MediaQuery
            .of(context)
            .size
            .width
        ? MediaQuery
        .of(context)
        .size
        .width * 0.05
        : MediaQuery
        .of(context)
        .size
        .height * 0.05;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_setHeader);
    setState(() {
      _controller.text = widget.list.listHeader;
    });
    Timer.run(() {
      _initializeTextStyle();
    });
    _controller.addListener(_changeTextSize);
  }

  _initializeTextStyle() {
    var fieldWidth = MediaQuery
        .of(context)
        .size
        .width * 0.80 - 12.0;
    double textWidth = _findTextWidth();
    var fontsize = min(50, (50 * fieldWidth / textWidth) * 0.3);
    fontsize = max(fontsize, 25);
    setState(() {
      textStyle = TextStyle(
          color: Colors.brown,
          fontSize: fontsize,
          fontFamily: 'DancingScript');
    });
    //After altering the size, we will check for font size limits
    if(fontsize == 50) {
      underflowFlag = true;
    } else if(fontsize == 25){
      overflowFlag = true;
    }
  }

  double _findTextWidth() {
    TextSpan ts = new TextSpan(style: textStyle, text: _controller.text);
    tp = new TextPainter(text: ts, textDirection: TextDirection.ltr);
    tp.layout();
    var textWidth = tp.width;
    return textWidth;
  }

  TextStyle _changeTextSize() {
    var fieldWidth = MediaQuery
        .of(context)
        .size
        .width * 0.80 - 12.0;
    double textWidth = _findTextWidth();
    var size;
    if (!overflowFlag && (textWidth - fieldWidth) > 5) {
      size = max(textStyle.fontSize - 1, 25);
      setState(() {
        textStyle = TextStyle(
            color: Colors.brown,
            fontSize: size,
            fontFamily: 'DancingScript');
      });
      if(size == 25){
         overflowFlag = true;
      }
      if(size < 50){
        underflowFlag = false;
      }
    } else if (!underflowFlag && (textWidth - fieldWidth) < -5) {
      size = min(textStyle.fontSize + 1, 50);
      setState(() {
        textStyle = TextStyle(
            color: Colors.brown,
            fontSize: size,
            fontFamily: 'DancingScript');
      });
      if(size == 50){
        underflowFlag = true;
      }
      if(size > 25){
        overflowFlag = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.40,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.75,
                  child: new ListView.builder(
                      itemCount: widget.list.listItems.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        final item = widget.list.listItems[index];
                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.startToEnd,
                          child: Padding(
                              padding: EdgeInsets.all(MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.015),
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
          width: MediaQuery
              .of(context)
              .size
              .width * 0.80,
          height: MediaQuery
              .of(context)
              .size
              .height * 0.70,
          child: listView,
        )
    );
  }
}
