import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:makealist/makealist/home/MyList.dart';
import 'package:makealist/makealist/persistence/FilePersistence.dart';

import 'PersistenceService.dart';

class FilePersistenceService with ChangeNotifier implements PersistenceService{
  FilePersistence repo;
  var logger = Logger();

  FilePersistenceService(){
    repo = new FilePersistence();
  }

  Future<int> saveList(MyList list) async {
    Map<String, dynamic> map = list.toJson();
    var index = await repo.saveObject(list.index.toString(), map);
    notifyListeners();
    return index;
  }

  Future<void> updateList(MyList list) async {
    Map<String, dynamic> map = list.toJson();
    await repo.saveObject(list.index.toString(), map);
    notifyListeners();
  }

  Future<MyList> getList(String key) async {
    Map<String, dynamic> map = await repo.getObject(key);
    return MyList.fromJson(map);
  }

  Future<List<MyList>> getAllLists() async {
    List<Map<String, dynamic>> rawList = await repo.getAllObjects();
    List<MyList> list = new List();
    if(rawList!=null)
    for (var value in rawList) {
      MyList fetchedList = MyList.fromJson(value);
      logger.i('MyList fetched is $fetchedList');
      list.add(MyList.fromJson(value));
    }
    return list;
  }

  @override
  List<MyList> getListsByDateRange(DateTime start, DateTime end) {
    // TODO: implement getListsByDateRange
    throw UnimplementedError();
  }

  @override
  Future<int> getNextIndex() async {
    int index = await repo.getNextIndex();
    logger.i('Index recieved $index latest');
    return index;
  }

  @override
  Future<bool> deleteList(MyList list) async{
    logger.i('Deleting list at '+list.index.toString()+' index');
    var result = await repo.removeObject(list.index.toString());
    if(result) {
      logger.i('hasListeners() = '+ hasListeners.toString());
      notifyListeners();
    }
    return result;
    }

}
