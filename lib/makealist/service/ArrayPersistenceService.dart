import 'package:flutter/widgets.dart';
import 'package:makealist/makealist/home/MyList.dart';
import 'package:makealist/makealist/persistence/ArrayPersistence.dart';

import 'PersistenceService.dart';

class ArrayPersistenceService implements PersistenceService{
  ArrayPersistence repo;
  PersistorService(){
    repo = new ArrayPersistence();
  }

  void saveList(MyList list){
    repo.saveList(list);
  }

  void updateList(MyList list){
    repo.updateList(list);
  }

  Future<MyList> getList(String key){

  }

  Future<List<MyList>> getAllLists(){
    return Future.delayed(Duration(seconds: 1), () => repo.getAll());
  }

  List<MyList> getListsByDateRange(DateTime start, DateTime end){

  }

}
