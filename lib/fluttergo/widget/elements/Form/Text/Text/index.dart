import 'package:flutter/material.dart';
import 'package:flutter_app_demo/fluttergo/widget/elements/Form/Text/Text/demo.dart';

class Demo extends StatefulWidget {
  static const String routeName = '/element/Form/Text/Text';

  @override
  State<StatefulWidget> createState() {
    return new _Demo();
  }
}

class _Demo extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return new TextDemo();
  }
}
