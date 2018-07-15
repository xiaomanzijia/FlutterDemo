import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _SampleAppPageState extends State<SampleAppPage> {

  static const platform = const MethodChannel("app.channel.shared.data");
  String dataShared = "No Data";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new Center(child: new Text(dataShared),),);
  }

  @override
  void initState() {
    getSharedText();
  }

  void getSharedText() async {
    var sharedData = await platform.invokeMethod("getSharedText");
    if (sharedData != null) {
      setState(() {
        dataShared = sharedData;
      });
    }
  }

}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _SampleAppPageState();

}


class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Sample Shared App Handler",
      theme: new ThemeData(
          primarySwatch: Colors.blue
      ),
      home: new SampleAppPage(),
    );
  }

}

void main() => new SampleApp();