import 'dart:typed_data';

import 'package:makealist/makealist/home/Item.dart';
import 'package:makealist/makealist/home/MyList.dart';

class ArrayPersistence {
  List<MyList> db = new List();

  ArrayPersistence(){
    MyList l1 = new MyList.header("Hindi Songs I can sing",0);
    MyList l2 = new MyList.header("To Do List",1);
    MyList l3 = new MyList.header("Movies I have to watch!",2);
    MyList l4 = new MyList.header("Meeting Mintues - 16/6/2020",3);
    MyList l5 = new MyList.header("Schedule for week",4);
    
    l1.listItems.add(new Item.text(text: 'Sapna Jahan'));
    l1.listItems.add(new Item.text(text: 'Emptiness'));

    db.add(l1);
    db.add(l2);
    db.add(l3);
    db.add(l4);
    db.add(l5);
  }

  void saveList(MyList list){
    db.add(list);
  }

  void updateList(MyList list){
    db[list.index] = list;
  }

  List<MyList> getAll(){
    return db;
  }

}