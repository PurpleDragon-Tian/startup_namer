import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: "",
    home: new Scaffold(
      appBar: new AppBar(title: new Text("Container Widget")),
      body: new ContainerWidget1(),
    ),
  ));
}

class ContainerWidget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Container(
        margin: const EdgeInsets.all(10.0),
        color: const Color(0xFFFFFF00),
        width: 48.0,
        height: 48.0,
      ),
    );
  }
}
