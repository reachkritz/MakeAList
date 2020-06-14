import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makealist/makealist/home/MyList.dart';
import 'package:makealist/makealist/service/PersistorService.dart';

import 'MyListClickableView.dart';
import 'MyListExpandableView.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _padding = EdgeInsets.all(20.0);
  PersistorService service = new PersistorService();

  Widget _showNewList() {
    return new Center(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.80,
            width: MediaQuery.of(context).size.width * 0.80,
            child: new Card(
                elevation: 5.0,
                borderOnForeground: true,
                shadowColor: Colors.black12,
                color: Color(0xFFFFD28E),
                child: new MyListCardView(new MyList()))));
  }

  @override
  Widget build(BuildContext context) {
    final layout = Padding(
      padding: _padding,
      child: Column(
        verticalDirection: VerticalDirection.down,
        children: [
          Expanded(
            child: CustomScrollView(slivers: <Widget>[
              const SliverAppBar(
                pinned: true,
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('To-Do Lists'),
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 4.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return MyListClickableView(index, new MyList.header("Hello test"));
                  },
                  childCount: 40,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Color(0xFF6AB7A8),
      body: layout,
      floatingActionButton: FloatingActionButton(
          heroTag: "addNewList",
          elevation: 2.0,
          hoverColor: Colors.cyan,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 20.0,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return _showNewList();
              },
            );
          }
          ),
    );
  }
}
