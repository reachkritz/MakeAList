import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';

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
  final _padding =
      EdgeInsets.only(top: 15.0, bottom: 5.0, left: 5.0, right: 5.0);
  TextEditingController _controller = new TextEditingController();
  TextStyle textStyle =
      TextStyle(color: Colors.black, fontSize: 50, fontFamily: 'Raleway');
  TextPainter tp;

  bool overflowFlag = false;
  bool underflowFlag = false;

  void _setHeader() {
    if (widget.list.listHeader != _controller.text) {
      setState(() {
        widget.list.listHeader = _controller.text;
      });
    }
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
    _calculateEfficiency();
  }

  //Callback function to compute efficiency upon updates from the underlying list object
  _calculateEfficiency() {
    int count = 0;
    if (widget.list.listItems.length != 0) {
      widget.list.listItems.forEach((element) {
        if (element.actionCode == 1) {
          count++;
        }
      });
    }
    if (widget.list.listItems.length != 0) {
      setState(() {
        efficiency = count / widget.list.listItems.length;
      });
    }
  }

  _initializeTextStyle() {
    var fieldWidth = MediaQuery.of(context).size.width * 0.80 - 12.0;
    double textWidth = _findTextWidth();
    var fontsize = min(50, (50 * fieldWidth / textWidth) * 0.3);
    fontsize = max(fontsize, 25);
    setState(() {
      textStyle = TextStyle(
          color: Colors.black,
          fontSize: fontsize.toDouble(),
          fontFamily: 'Raleway');
    });
    //After altering the size, we will check for font size limits
    if (fontsize == 50) {
      underflowFlag = true;
    } else if (fontsize == 25) {
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

  @override
  Widget build(BuildContext context) {
    final listView = Column(children: [
      Container(
        color: Colors.yellow,
        height: MediaQuery.of(context).size.height * 0.18,
        padding: _padding,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.50,
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.025,
                  top : MediaQuery.of(context).size.width * 0.035),
              child: AutoSizeTextField(
                cursorColor: Colors.black,
                maxLength: 50,
                maxLengthEnforced: true,
                controller: _controller,
                style: textStyle,
                decoration: InputDecoration.collapsed(
                  hintText: "Title...",
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.30,
              height: MediaQuery.of(context).size.height * 0.40,
              child: new CircularPercentIndicator(
                radius: MediaQuery.of(context).size.width * 0.25,
                lineWidth: 8.0,
                animation: true,
                percent: efficiency,
                center: new Text(
                  makeText(efficiency),
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.purple,
              ),
            )
          ],
        ),
      ),
      Container(
          height: MediaQuery.of(context).size.height * 0.40,
          width: MediaQuery.of(context).size.width * 0.80,
          child: new ListView.builder(
              itemCount: widget.list.listItems.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.startToEnd,
                  child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.015),
                      child: Row(
                        children: [
                          widget.list.listItems[index],
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.list.removeWithRecomputation(index);
                              });
                            },
                            child: Icon(Icons.delete_forever),
                          )
                        ],
                      )),
                  onDismissed: (direction) {
                    setState(() {
                      widget.list.removeWithRecomputation(index);
                    });
                  },
                );
              })),
      FloatingActionButton(
        elevation: 2.0,
        hoverColor: Colors.cyan,
        child: Icon(
          Icons.add,
          size: _getIconSize(),
        ),
        onPressed: () {
          if (_noEmptyItemAlready()) {
            setState(() {
              widget.list.addWithRecomputation(new Item.flag(focusFlag: true));
            });
          }
        },
      )
    ]);
    final unfocus = () {
      FocusScopeNode currentFocus = FocusScope.of(context);
      setState(() {
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      });
    };
    return GestureDetector(onTap: unfocus, child: Center(child: listView));
  }

  //Utility function to disallow addition of a new item to the list in case there are already empty items
  bool _noEmptyItemAlready() {
    for (Item item in widget.list.listItems) {
      if (item.text == null || item.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  String makeText(double efficiency) {
    return (efficiency * 100).toStringAsFixed(1) + "%";
  }
}
