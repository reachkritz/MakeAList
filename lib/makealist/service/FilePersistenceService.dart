import 'package:makealist/makealist/home/MyList.dart';
import 'package:makealist/makealist/persistence/FilePersistence.dart';

import 'PersistenceService.dart';

class FilePersistenceService implements PersistenceService{
  FilePersistence repo;
  PersistorService(){
    repo = new FilePersistence();
  }

  void saveList(MyList list){
    Map<String, dynamic> map = list.toJson();
    repo.saveObject(list.index.toString(), map);
  }

  void updateList(MyList list){
    repo.updateList(list);
  }

  MyList getList(String key){

  }

  List<MyList> getAllLists(){
    return repo.getAll();
  }

  List<MyList> getListsByDateRange(DateTime start, DateTime end){

  }

}
