import 'package:flutter/material.dart';
import 'package:startup_namer/common_widget.dart' as common;

void main() {
  runApp(new MaterialApp(
    title: 'Material Widget',
    home: new TutorialHome(),
  ));
}

class TutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.menu),
            tooltip: "Navigation menu",
            onPressed: null),
        title: new Text("Example title"),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search), tooltip: "Search", onPressed: null)
        ],
      ),
      body: new Column(
        children: <Widget>[
          new Text("Hello Material Widget"),
          new MyBtn(),
          new Counter(),
          new common.Counter()
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: null,
        tooltip: "Floating",
        child: new Icon(Icons.add),
      ),
    );
  }
}

class MyBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      onTap: () {
        print("Mybtn was tapped");
      },
      onHorizontalDragStart: (state) {
        print("horizontal drag start");
      },
      onHorizontalDragEnd: (state) {
        print("horizontal drag end");
      },
      onHorizontalDragCancel: () {
        print("horizontal drag cancel");
      },
      child: new Container(
        height: 30,
        padding: const EdgeInsets.all(6.0),
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(5.0),
            color: Colors.green[500]),
        child: new Center(child: new Text("Engine")),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  _CounterState createState() {
    return new _CounterState();
  }
}

/**
 * 注意setState方法的使用。更新ui
 */
class _CounterState extends State<Counter> {
  int _counter = 0;
  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      children: <Widget>[
        new RaisedButton(
          onPressed: _increment,
          child: new Text("Increment"),
        ),
        new Text("Count:$_counter"),
        new IconButton(
            icon: new Icon(Icons.exposure_zero), onPressed: _resetCounter)
      ],
    );
  }

  void _resetCounter() {
    if (_counter != 0) {
      setState(() {
        _counter = 0;
      });
    }
  }
}
