
import 'package:flutter/cupertino.dart';
import 'package:makealist/makealist/home/MyList.dart';

abstract class PersistenceService with ChangeNotifier{
  Future<int> saveList(MyList list);

  void updateList(MyList list);

  Future<MyList> getList(String key);

  Future<List<MyList>> getAllLists();

  List<MyList> getListsByDateRange(DateTime start, DateTime end);

  Future<int> getNextIndex();

  Future<bool> deleteList(MyList list);
}