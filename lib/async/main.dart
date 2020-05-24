import 'package:flutter/material.dart';


void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State createState() {
    return new _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
      appBar: new AppBar(
        title: Text('Plugin example app'),
      ),
      body: Center(
        child: Text("Stream"),
      ),
      ),
    );
  }
}
