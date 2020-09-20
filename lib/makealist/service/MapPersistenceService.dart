import 'package:flutter/widgets.dart';
import 'package:makealist/makealist/home/MyList.dart';
import 'package:makealist/makealist/persistence/MapPersistence.dart';

import 'PersistenceService.dart';

class MapPersistenceService implements PersistenceService{
  MapPersistence repo;
  MapPersistenceService(){
    repo = new MapPersistence();
  }

  int saveList(MyList list){
    repo.saveList(list);
    return repo.getSize();
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

  @override
  Future<int> getNextIndex() {
    return Future.delayed(Duration(seconds: 1), () => 0);
  }

  @override
  Future<bool> deleteList(MyList list) {
    return  Future.delayed(Duration(seconds: 1), () => repo.deleteList(list.index));
  }

}
