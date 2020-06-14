import 'package:makealist/makealist/home/MyListExpandableView.dart';
import 'package:makealist/makealist/persistence/ArrayPersistence.dart';
import 'package:makealist/makealist/persistence/FilePersistence.dart';
import 'package:makealist/makealist/persistence/Repository.dart';

class PersistorService{
  ArrayPersistence repo;
  PersistorService(){
    repo = new ArrayPersistence();
  }

  void saveList(MyListCardView list){
    repo.saveItem(list);
  }

  MyListCardView getList(String key){

  }

  List<MyListCardView> getAllLists(){
    return repo.getAll();
  }

  List<MyListCardView> getListsByDateRange(DateTime start, DateTime end){

  }

}