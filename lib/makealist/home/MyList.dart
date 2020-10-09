import 'package:flutter/material.dart';

import 'Item.dart';

class MyList with ChangeNotifier{
  static List<GlobalKey<FormState>> _formKey = new List();
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

  MyList.complete(String listHeader, int index, List<Item> listItems){
    this.listHeader = listHeader;
    this.listItems = listItems;
    this.index = index;
  }

  MyList.clone(MyList list): this.complete(list.listHeader, list.index, list.listItems);


  MyList.fromJson(Map<String, dynamic> json){
    index = json['index'];
    listHeader = json['listHeader'];
    listItems = new List();
    json['listItems'].forEach((item) {
      addWithRecomputation(new Item.fromJson(item));
    });
  }

  void addWithRecomputation(Item item) {
    //Adding a static key attribute to each item to resolve the disappearing keyboard issue
    _formKey.add(new GlobalKey<FormState>());
    item.formKey = _formKey.last;
     if(listItems.isNotEmpty){
      listItems.last.focusFlag = false;
     }
     item.addListener(_recomputeEfficiency);//notify listeners incase of toggle
     listItems.add(item);
     _recomputeEfficiency(); //notify listeners incase of adding new items to list
  }

  _recomputeEfficiency(){
    notifyListeners();
  }

  void removeWithRecomputation(int index) {
    listItems.removeAt(index);
    _formKey.removeAt(index);
    if(listItems.isNotEmpty && index == listItems.length){
      listItems.last.focusFlag = true;
    } else if(index!=0){
      listItems[index].focusFlag = true;
    }
    _recomputeEfficiency(); //notify listeners incase of deleting items from list
  }


  // method
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'listHeader': listHeader,
      'listItems': listItems.map((item) => item.toJson()).toList()
    };
  }

}