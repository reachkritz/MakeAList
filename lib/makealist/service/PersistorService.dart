import 'package:makealist/makealist/home/MyList.dart';
import 'package:makealist/makealist/persistence/ArrayPersistence.dart';

class PersistorService{
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

  MyList getList(String key){

  }

  List<MyList> getAllLists(){
    return repo.getAll();
  }

  List<MyList> getListsByDateRange(DateTime start, DateTime end){

  }

}