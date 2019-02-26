import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/fluttergo/components/category.dart';
import 'package:flutter_app_demo/fluttergo/views/home.dart';

var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new AppPage();
});

var categoryHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String name = params['type'].first;
  return new CategoryHome(name);
});
