import 'dart:typed_data';

import 'package:makealist/makealist/home/MyListExpandableView.dart';
import 'package:makealist/makealist/persistence/Repository.dart';

class ArrayPersistence {
  List<MyListCardView> db = new List();

  void saveItem(MyListCardView list){
    db.add(list);
  }

  List<MyListCardView> getAll(){
    return db;
  }

}