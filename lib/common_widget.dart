import 'package:flutter/material.dart';

//void main() {
//  runApp(new TextWidget());
//}

class TextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Text(
        "Hello",
        textDirection: TextDirection.rtl,
        softWrap: true,
      ),
    );
  }
}

//Row相当于是横向布局，横向排列子组件
class MyAppBar extends StatelessWidget {
  final Widget title;

  MyAppBar({this.title});

  @override
  Widget build(BuildContext context) {
    //Row的构造方法参数就是一个Widget集合
    return new Container(
      //56不是真是像素，是逻辑上的像素
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      decoration: new BoxDecoration(color: Colors.blue[500]),
      child: new Row(
        children: <Widget>[
          new IconButton(
              icon: new Icon(Icons.ac_unit),
              tooltip: 'Navigation menu',
              onPressed: null),
          new IconButton(
              icon: new Icon(Icons.search), tooltip: "Search", onPressed: null),
          new IconButton(icon: new Icon(Icons.print), onPressed: null),
          new IconButton(icon: new Icon(Icons.list), onPressed: null),
          new IconButton(icon: new Icon(Icons.remove_circle), onPressed: null),
          new Expanded(
            child: title,
            flex: 1,
          )
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Material(
      child: new MyAppBar(
        title: new Text(
          "title",
          style: Theme.of(context).primaryTextTheme.title,
        ),
      ),
//      child: new Column(
//        children: <Widget>[
//          new MyAppBar(
//            title: new Text(
//              "title",
//              style: Theme.of(context).primaryTextTheme.title,
//            ),
//          ),
//          new Expanded(child: new Center(child: new Text("Hello World")))
//        ],
//      ),
    );
  }
}

class CounterDisplay extends StatelessWidget {
  int count;

  CounterDisplay(this.count);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Text("CommonCount: $count");
  }
}

class CounterIncrement extends StatelessWidget {
  VoidCallback press;

  CounterIncrement(this.press);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new RaisedButton(
        child: new Text("CommonIncrement"), onPressed: press);
  }
}

class ResetCounter extends StatelessWidget {
  VoidCallback reset;

  ResetCounter(this.reset);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new RaisedButton(
      onPressed: reset,
      child: new Text("CommonReset"),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  CounterState createState() {
    // TODO: implement createState
    return new CounterState();
  }
}

class CounterState extends State<Counter> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      children: <Widget>[
        new CounterIncrement(_press),
        new CounterDisplay(_count),
        new ResetCounter(_reset)
      ],
    );
  }

  void _press() {
    setState(() {
      _count++;
    });
  }

  void _reset() {
    setState(() {
      if (_count != 0) {
        _count = 0;
      }
    });
  }
}
