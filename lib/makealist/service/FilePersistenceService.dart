import 'package:logger/logger.dart';
import 'package:makealist/makealist/home/MyList.dart';
import 'package:makealist/makealist/persistence/FilePersistence.dart';

import 'PersistenceService.dart';

class FilePersistenceService implements PersistenceService{
  FilePersistence repo;
  var logger = Logger();

  FilePersistenceService(){
    repo = new FilePersistence();
  }

  int saveList(MyList list){
    Map<String, dynamic> map = list.toJson();
    repo.saveObject(list.index.toString(), map);
  }

  void updateList(MyList list){
    Map<String, dynamic> map = list.toJson();
    repo.saveObject(list.index.toString(), map);
  }

  Future<MyList> getList(String key) async {
    Map<String, dynamic> map = await repo.getObject(key);
    return MyList.fromJson(map);
  }

  Future<List<MyList>> getAllLists() async {
    List<Map<String, dynamic>> rawList = await repo.getAllObjects();
    List<MyList> list = new List();
    for (var value in rawList) {
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
    return await repo.removeObject(list.index.toString());
  }

}
