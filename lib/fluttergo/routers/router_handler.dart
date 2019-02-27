import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/fluttergo/components/category.dart';
import 'package:flutter_app_demo/fluttergo/views/home.dart';
import 'package:flutter_app_demo/fluttergo/widget/404.dart';

var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new AppPage();
});

var categoryHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String name = params['type'].first;
  print("categoryHandler---> $name");
  return new CategoryHome(name);
});

var widgetNotFoundHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new WidgetNotFound();
});
