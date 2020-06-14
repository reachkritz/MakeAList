import 'dart:typed_data';

import 'package:makealist/makealist/home/MyList.dart';
import 'package:makealist/makealist/persistence/Repository.dart';

class ArrayPersistence {
  List<MyList> db = new List();

  void saveItem(MyList list){
    db.add(list);
  }

  List<MyList> getAll(){
    return db;
  }

}