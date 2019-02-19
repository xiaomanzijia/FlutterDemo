import 'package:flutter/material.dart';
import 'package:flutter_app_demo/fluttergo/model/widget.dart';

import 'DropdownButton/index.dart' as DropdownButton;

List<WidgetPoint> widgetPoints = [
  WidgetPoint(
    name: 'DropdownButton',
    routerName: DropdownButton.Demo.routeName,
    buildRouter: (BuildContext context) => DropdownButton.Demo(),
  )
];
