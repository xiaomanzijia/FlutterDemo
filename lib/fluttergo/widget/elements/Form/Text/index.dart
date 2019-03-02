import 'package:flutter/material.dart';
import 'package:flutter_app_demo/fluttergo/model/widget.dart';
import 'Text/index.dart' as Text;
import 'RichText/index.dart' as RichText;


List<WidgetPoint> widgetPoints = [
  WidgetPoint(
    name: 'Text',
    routerName: Text.Demo.routeName,
    buildRouter: (BuildContext context) => Text.Demo(),
  ),
  WidgetPoint(
    name: 'RichText',
    routerName: RichText.Demo.routeName,
    buildRouter: (BuildContext context) => RichText.Demo(),
  )
];
