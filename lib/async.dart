import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: uri_does_not_exist
import 'package:http/http.dart' as http;

void main() => runApp(new SampleApp());

class _SampleAppPageState extends State<SampleAppPage> {

  List widgets = [];


  @override
  void initState() {
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sample APp"),
      ),
      body: new ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (BuildContext context, int position) {
            return getRow(position);
          }),
    );
  }

  Widget getRow(int position) {
    return new Padding(padding: new EdgeInsets.all(10.0),
        child: new Text("Row ${widgets[position]["title"]}"));
  }

  void loadData() async {
    String dataURL = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(dataURL);
    setState(() {
      widgets = JSON.decode(response.body);
    });
  }

}

class SampleAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SampleAppPageState();

}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Sample App",
      theme: new ThemeData(
          primarySwatch: Colors.blue
      ),
      home: new SampleAppPage(),
    );
  }

}