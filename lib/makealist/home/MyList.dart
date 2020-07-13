import 'package:flutter/material.dart';

import 'Item.dart';

class MyList with ChangeNotifier{
  int index;
  String listHeader;
  List<Item> listItems;

  MyList(int index){
    listItems = new List();
    this.index = index;
  }

  MyList.header(String header, int index){
    listHeader = header;
    listItems = new List();
    this.index = index;
  }

  void addWithFlags(Item item) {
     if(listItems.isNotEmpty){
       listItems.last.focusFlag = false;
     }
     listItems.add(item);
     notifyListeners();
  }

  void removeWithFlags(int index) {
    listItems.removeAt(index);
    if(listItems.isNotEmpty && index == listItems.length){
      listItems.last.focusFlag = true;
    } else {
      listItems[index].focusFlag = true;
    }
    notifyListeners();
  }
}