import 'package:flutter/widgets.dart';
import 'package:makealist/makealist/home/MyList.dart';
import 'package:makealist/makealist/persistence/MapPersistence.dart';

import 'PersistenceService.dart';

class MapPersistenceService with ChangeNotifier implements PersistenceService{
  MapPersistence repo;
  MapPersistenceService(){
    repo = new MapPersistence();
  }

  Future<int> saveList(MyList list){
    repo.saveList(list);
    repo.getSize();
    notifyListeners();
  }

  void updateList(MyList list){
    repo.updateList(list);
    notifyListeners();
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
    Future.delayed(Duration(seconds: 1), () => {
      repo.deleteList(list.index),
      notifyListeners(),
    });
  }

}
