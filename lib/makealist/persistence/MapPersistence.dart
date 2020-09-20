import 'dart:typed_data';

import 'package:makealist/makealist/home/Item.dart';
import 'package:makealist/makealist/home/MyList.dart';

class MapPersistence {
  Map<int, MyList> db = new Map();

  MapPersistence(){
    MyList l1 = new MyList.header("Hindi Songs I can sing",0);
    MyList l2 = new MyList.header("To Do List",1);
    MyList l3 = new MyList.header("Movies I have to watch!",2);
    MyList l4 = new MyList.header("Meeting Mintues - 16/6/2020",3);
    MyList l5 = new MyList.header("Schedule for week",4);
    
    l1.addWithFlags(new Item.textFlag(text: 'Sapna Jahan', focusFlag: true));
    l1.addWithFlags(new Item.textFlag(text: 'Emptiness', focusFlag: true));

    db.putIfAbsent(l1.index, () => l1);
    db.putIfAbsent(l2.index, () => l2);
    db.putIfAbsent(l3.index, () => l3);
    db.putIfAbsent(l4.index, () => l4);
    db.putIfAbsent(l5.index, () => l5);
  }

  void saveList(MyList list){
    db.putIfAbsent(list.index, ()=> list);
  }

  void updateList(MyList list){
    db.update(list.index, (value) => list);
  }

  List<MyList> getAll(){
    List<MyList> lists;
   db.forEach((key, value) {
     lists.add(value);
   });
   return lists;
  }

  int getSize(){
    return db.length;
  }

  bool deleteList(int index){
    if(db.containsKey(index)){
      db.remove(index);
      return true;
    }
    else return false;
  }

}