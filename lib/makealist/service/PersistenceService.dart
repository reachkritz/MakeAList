
import 'package:makealist/makealist/home/MyList.dart';

abstract class PersistenceService{
  void saveList(MyList list);

  void updateList(MyList list);

  Future<MyList> getList(String key);

  Future<List<MyList>> getAllLists();

  List<MyList> getListsByDateRange(DateTime start, DateTime end);
}