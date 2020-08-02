
import 'package:makealist/makealist/home/MyList.dart';

abstract class PersistenceService{
  void saveList(MyList list);

  void updateList(MyList list);

  MyList getList(String key);

  List<MyList> getAllLists();

  List<MyList> getListsByDateRange(DateTime start, DateTime end);
}