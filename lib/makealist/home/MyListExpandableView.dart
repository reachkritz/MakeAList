import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Item.dart';
import 'MyList.dart';

class MyListCardView extends StatefulWidget {
  MyList list;
  @override
  State<StatefulWidget> createState() {
    return MyListCardViewState(list);
  }

  MyListCardView(MyList underlyingList){
    list = underlyingList;
  }
}

class MyListCardViewState extends State<MyListCardView> {
  MyList list;
  List<int> selectedItems = new List();
  final _padding = EdgeInsets.all(5.0);

  MyListCardViewState(MyList list){
    this.list = list;
  }

  void _setHeader(String input) {
    setState(() {
      list.listHeader = input;
    });
  }

  double _getIconSize() {
    return MediaQuery.of(context).size.height >
        MediaQuery.of(context).size.width
        ? MediaQuery.of(context).size.width * 0.05
        : MediaQuery.of(context).size.height * 0.05;
  }

  void _submitList() {
    setState(() {
      if (list.listHeader == null || list.listHeader.isEmpty) {
        list.listHeader = "New List - " + TimeOfDay.now().toString();
      }
    });
  }
  @override
  void initState() {
    super.initState();
    Item i1 = new Item();
    Item i2 = new Item();
    Item i3 = new Item();
    setState(() {
      list.listItems.add(i1);
      list.listItems.add(i2);
      list.listItems.add(i3);
    });
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
                    enableSuggestions: true,
                    keyboardType: TextInputType.text,
                    onChanged: _setHeader,
                    cursorColor: Colors.black38,
                    maxLength: 50,
                    maxLengthEnforced: true,
                    style: TextStyle(
                        color: Colors.brown,
                        fontSize: 60,
                        fontFamily: 'DancingScript'),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: Colors.brown,
                            fontSize: 30,
                            fontFamily: 'DancingScript'),
                        labelText: 'Title...'))),
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              width: MediaQuery.of(context).size.width * 0.70,
              child: new ListView.builder(
                  itemCount: list.listItems.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    final item = list.listItems[index];
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      child: Padding(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
                          child: Row(
                            children: [
                              list.listItems[index],
                              IconButton(
                                iconSize: _getIconSize(),
                                icon: Icon(
                                  Icons.delete_forever,
                                ),
                                onPressed: () {
                                  setState(() {
                                    list.listItems.removeAt(index);
                                  });
                                },
                              )
                            ],
                          )
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          list.listItems.removeAt(index);
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
                  list.listItems.add(new Item());
                });
              },
            ),
            IconButton(
                    iconSize: MediaQuery.of(context).size.height * 0.05,
                    icon: Icon(
                      Icons.check,
                      color: Colors.lightBlue,
                      size: MediaQuery.of(context).size.height * 0.05,
                    ),
                    onPressed: _submitList
                )
              ]
        ));
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.80,
        height: MediaQuery.of(context).size.height * 0.80,
        child: listView,
      )
    );
  }
}
