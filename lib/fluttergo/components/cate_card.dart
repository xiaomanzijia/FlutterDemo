import 'package:flutter/material.dart';
import 'package:flutter_app_demo/fluttergo/model/cat.dart';

class CateCard extends StatefulWidget {
  final Cat category;

  CateCard({@required this.category});

  @override
  State<StatefulWidget> createState() {
    return new _CateCardState();
  }
}

class _CateCardState extends State<CateCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
