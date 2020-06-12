import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Item.dart';

class MyList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyListState();
  }
}

class MyListState extends State<MyList> {
  String listHeader;
  List<Item> listItems = new List();
  List<int> selectedItems = new List();
  final _padding = EdgeInsets.all(5.0);


  void _setHeader(String input) {
    setState(() {
      listHeader = input;
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
      if (listHeader == null || listHeader.isEmpty) {
        listHeader = "New List - " + TimeOfDay.now().toString();
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
      listItems.add(i1);
      listItems.add(i2);
      listItems.add(i3);
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
                  itemCount: listItems.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    final item = listItems[index];
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      child: Padding(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
                          child: Row(
                            children: [
                              listItems[index],
                              IconButton(
                                iconSize: _getIconSize(),
                                icon: Icon(
                                  Icons.delete_forever,
                                ),
                                onPressed: () {
                                  setState(() {
                                    listItems.removeAt(index);
                                  });
                                },
                              )
                            ],
                          )
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          listItems.removeAt(index);
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
                  listItems.add(new Item());
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
