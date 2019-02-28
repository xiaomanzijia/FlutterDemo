import 'package:flutter/material.dart';
import 'package:flutter_app_demo/fluttergo/widget/elements/Form/Button/DropDownButton/demo.dart';

class Demo extends StatefulWidget {
  static const String routeName = '/element/Form/Button/DropdownButton';

  @override
  State<StatefulWidget> createState() {
    return new _DemoState();
  }
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return new DropdownButtonCustom();
  }
}
