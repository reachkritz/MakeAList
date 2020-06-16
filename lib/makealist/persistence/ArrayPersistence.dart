import 'dart:typed_data';

import 'package:makealist/makealist/home/Item.dart';
import 'package:makealist/makealist/home/MyList.dart';

class ArrayPersistence {
  List<MyList> db = new List();

  ArrayPersistence(){
    MyList l1 = new MyList.header("Hindi Songs I can sing");
    MyList l2 = new MyList.header("To Do List");
    MyList l3 = new MyList.header("Movies I have to watch!");
    MyList l4 = new MyList.header("Meeting Mintues - 16/6/2020");
    MyList l5 = new MyList.header("Schedule for week");
    
    l1.listItems.add(new Item.text("Sapna Jahan"));
    l1.listItems.add(new Item.text("Emptiness"));

    db.add(l1);
    db.add(l2);
    db.add(l3);
    db.add(l4);
    db.add(l5);
  }

  void saveItem(MyList list){
    db.add(list);
  }

  List<MyList> getAll(){
    return db;
  }

}