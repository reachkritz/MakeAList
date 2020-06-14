import 'Item.dart';

class MyList{
  String listHeader;
  List<Item> listItems;

  MyList(){
    listItems = new List();
  }

  MyList.header(String header){
    listHeader = header;
    listItems = new List();
  }
}