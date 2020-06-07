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
  List<Item> listItems;
  final _padding = EdgeInsets.all(5.0);

  void _setHeader(String input) {
    setState(() {
      listHeader = input;
    });
  }

  void _submitList(){
    setState(() {
      if(listHeader==null || listHeader.isEmpty){
        listHeader = "New List - "+TimeOfDay.now().toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Item i1 = new Item(1, "hello");
    Item i2 = new Item(2, "hye");
    Item i3 = new Item(3, "bye");
    listItems = new List();
    listItems.add(i1);
    listItems.add(i2);
    listItems.add(i3);

    final listView = new Padding(
        padding: EdgeInsets.all(1.0),
        child: Column(
          children: [
            TextField(
                enableSuggestions: true,
                keyboardType: TextInputType.text,
                onChanged: _setHeader,
                style: TextStyle(
                    color: Colors.brown,
                    fontSize: 40,
                    fontFamily: 'DancingScript'
                ),
                decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.brown,
                      fontSize: 20,
                      fontFamily: 'DancingScript'
                    ),
                    labelText: 'Enter Title'
                )),
            Container(
              height: MediaQuery.of(context).size.height * 0.50,
              width: MediaQuery.of(context).size.width * 0.50,
              child: new ListView.builder(
                  itemCount: listItems.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return new Padding(
                      padding: _padding,
                      child: Text(listItems[index].text),
                    );
                  }),
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
          ],
        ));
    return listView;
  }
}
