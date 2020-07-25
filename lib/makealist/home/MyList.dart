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
     item.addListener(_recomputeEfficiency);//notify listeners incase of toggle
     if(listItems.isNotEmpty){
       listItems.last.focusFlag = false;
     }
     listItems.add(item);
     _recomputeEfficiency(); //notify listeners incase of adding new items to list
  }

  _recomputeEfficiency(){
    notifyListeners();
  }

  void removeWithFlags(int index) {
    listItems.removeAt(index);
    if(listItems.isNotEmpty && index == listItems.length){
      listItems.last.focusFlag = true;
    } else {
      listItems[index].focusFlag = true;
    }
    _recomputeEfficiency(); //notify listeners incase of deleting items from list
  }
}