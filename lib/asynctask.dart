import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
// ignore: uri_does_not_exist
import 'package:http/http.dart' as http;

class _SampleAppPageState extends State<SampleAppPage> with WidgetsBindingObserver {

  AppLifecycleState _lastLifecyleState;

  List widgets = [];

  showLoadingDialog() {
    if (widgets.length == 0) {
      return true;
    }
    return false;
  }

  getProgressDialog() {
    return new Center(child: new CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    if(_lastLifecyleState == null) {
      return new Text("This widget has not observed any lifecycle changes", textDirection: TextDirection.ltr);
    } else {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text("Sample App"),
          ),
          body: getBody());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadData();
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lastLifecyleState = state;
    });
  }



  loadData() async {
    ReceivePort receivePort = new ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);

    // The 'echo' isolate sends it's SendPort as the first message
    SendPort sendPort = await receivePort.first;

    List msg = await sendReceive(
        sendPort, "https://jsonplaceholder.typicode.com/posts");

    setState(() {
      widgets = msg;
    });
  }

  static dataLoader(SendPort sendPort) async {
    ReceivePort port = new ReceivePort();

    sendPort.send(port.sendPort);

    await for (var msg in port) {
      String data = msg[0];
      SendPort replyTo = msg[1];

      String dataURL = data;

      http.Response response = await http.get(dataURL);

      replyTo.send(json.decode(response.body));
    }
  }

  Future sendReceive(SendPort sendPort, String s) {
    ReceivePort response = new ReceivePort();
    sendPort.send([s, response.sendPort]);
    return response.first;
  }

  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  getListView() => new ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });

  getRow(int position) {
    return new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Text("Row ${widgets[position]["title"]}"));
  }


}

void main() {
  runApp(new SampleApp());
}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sample App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() => new _SampleAppPageState();
}
