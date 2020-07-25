import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
  double efficiency = 0.0;
  final _padding = EdgeInsets.only( top : 35.0, bottom: 5.0,left: 5.0, right: 5.0);
  TextEditingController _controller = new TextEditingController();
  TextStyle textStyle = TextStyle(
      color: Colors.black,
      fontSize: 50,
      fontFamily: 'Raleway');
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
    widget.list.addListener(_calculateEfficiency);
    _controller.addListener(_setHeader);
    setState(() {
      _controller.text = widget.list.listHeader;
    });
    Timer.run(() {
      _initializeTextStyle();
    });
    _controller.addListener(_changeTextSize);
    _calculateEfficiency();
  }

  _calculateEfficiency(){
    int count = 0;
    widget.list.listItems.forEach((element) {
      if(element.itemAction == Colors.lightGreen){
        count++;
      }
    });
    setState(() {
      efficiency = count/widget.list.listItems.length;
    });
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
          color: Colors.black,
          fontSize: fontsize,
          fontFamily: 'Raleway');
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
            color: Colors.black,
            fontSize: size,
            fontFamily: 'Raleway');
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
            color: Colors.black,
            fontSize: size,
            fontFamily: 'Raleway');
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
    final listView = Column(
            children: [
              Container(
                color: Colors.yellow,
                  padding: _padding,
                  child: Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.50,
                            child : TextField(
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.black,
                                maxLength: 50,
                                maxLengthEnforced: true,
                                controller: _controller,
                                style: textStyle,
                                decoration: InputDecoration.collapsed(
                                     hintText: "Title...",
                                     hintStyle: TextStyle(
                                         fontSize: 20,
                                         color: Colors.black,
                                     ),
                                    ))),
                        Container(
                                width: MediaQuery.of(context).size.width * 0.22,
                                height: MediaQuery.of(context).size.width * 0.22,
                          child: new CircularPercentIndicator(
                            radius: MediaQuery.of(context).size.width * 0.19,
                            lineWidth: 13.0,
                            animation: true,
                            percent: efficiency,
                            center: new Text(
                              makeText(efficiency),
                              style:
                              new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.purple,
                          ),
                        )
                      ],
                    ),
                  ),
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
                                  GestureDetector( onTap: () {
                                    setState(() {
                                      widget.list.removeWithFlags(index);
                                    });
                                  },
                                      child: Icon(Icons.delete_forever),
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
        );
    return Center(
        child: listView
    );
  }

  String makeText(double efficiency) {
    return (efficiency*100).toStringAsFixed(2) + "%";
  }
}
