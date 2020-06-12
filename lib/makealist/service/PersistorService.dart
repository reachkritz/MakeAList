import 'package:makealist/makealist/home/MyList.dart';
import 'package:makealist/makealist/persistence/FilePersistence.dart';

class PersistorService{
  FilePersistence filePersistence;
  PersistorService(){
    filePersistence = new FilePersistence();
  }

  void saveList(MyList list){

  }

  MyList getList(String key){

  }

  List<MyList> getAllLists(){

  }

  List<MyList> getListsByDateRange(DateTime start, DateTime end){

  }

}