import 'Item.dart';

class MyList{
  int index;
  String listHeader;
  List<Item> listItems;

  MyList(int index){
    listItems = new List();
    this.index = index;
  }

  MyList.header(String header, int index){
    listHeader = header;
    listItems = new List();
    this.index = index;
  }
}