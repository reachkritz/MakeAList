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

  void _submitList() {
    setState(() {
      if (listHeader == null || listHeader.isEmpty) {
        listHeader = "New List - " + TimeOfDay.now().toString();
      }
    });
  }

  void _deleteItems(){ // call _deleteItems() on clicking delete button
    setState(() {
      //set your state
      for (final index in selectedItems){
        log("Index" +index.toString());
        listItems.removeAt(index);
      }
      selectedItems.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    Item i1 = new Item();
    Item i2 = new Item();
    Item i3 = new Item();
    listItems.add(i1);
    listItems.add(i2);
    listItems.add(i3);

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
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width * 0.70,
              child: new ListView.builder(
                  itemCount: listItems.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return new GestureDetector(
                        onLongPress: () {
                          if(selectedItems.contains(index))
                            selectedItems.remove(index);
                          else
                            selectedItems.add(index);
                        },
                        onTap: () {
                          if(selectedItems.contains(index))
                            selectedItems.remove(index);
                          else
                            selectedItems.add(index);
                        },
                    child: Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
                        child: listItems[index]
                    ));
                  })
            ),
            Row(
              children: [
                IconButton(
                    iconSize: MediaQuery.of(context).size.height * 0.05,
                    icon: Icon(
                      Icons.check,
                      color: Colors.lightBlue,
                      size: MediaQuery.of(context).size.height * 0.05,
                    ),
                    onPressed: _submitList
                ),
                IconButton(
                    iconSize: MediaQuery.of(context).size.height * 0.05,
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.lightBlue,
                      size: MediaQuery.of(context).size.height * 0.05,
                    ),
                    onPressed: _deleteItems
                ),
              ],
            )
          ],
        ));
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      height: MediaQuery.of(context).size.height * 0.80,
      child: listView,
    );
  }
}
