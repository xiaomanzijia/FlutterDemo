import 'package:flutter/material.dart';
import 'package:flutter_app_demo/fluttergo/model/widget.dart';

import 'DropdownButton/index.dart' as DropdownButton;
import 'FlatButton/index.dart' as FlatButton;

List<WidgetPoint> widgetPoints = [
  WidgetPoint(
    name: 'DropdownButton',
    routerName: DropdownButton.Demo.routeName,
    buildRouter: (BuildContext context) => DropdownButton.Demo(),
  ),
  WidgetPoint(
    name: 'FlatButton',
    routerName: FlatButton.Demo.routeName,
    buildRouter: (BuildContext context) => FlatButton.Demo(),
  )
];
