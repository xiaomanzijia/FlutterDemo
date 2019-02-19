import 'package:flutter/material.dart';

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
    return new Center(child: Text('DropDownButton Demo'));
  }
}
