import 'package:flutter/material.dart';
import 'package:flutter_app_demo/fluttergo/model/widget.dart';
import 'Text/index.dart' as Text;

List<WidgetPoint> widgetPoints = [
  WidgetPoint(
    name: 'Text',
    routerName: Text.Demo.routeName,
    buildRouter: (BuildContext context) => Text.Demo(),
  ),
];
