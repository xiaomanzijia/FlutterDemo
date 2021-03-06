import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_app_demo/fluttergo/routers/app.dart';
import 'package:flutter_app_demo/fluttergo/routers/routers.dart';
import 'package:flutter_app_demo/fluttergo/utils/provider.dart';
import 'views/home.dart';

const int ThemeColor = 0xFFC91B3A;

var db;

class MyApp extends StatelessWidget {
  MyApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    showWeclomePage();
    return new MaterialApp(
      title: 'title',
      theme: new ThemeData(
          primaryColor: Color(ThemeColor),
          backgroundColor: Color(0xFFEFEFEF),
          accentColor: Color(0xFF888888),
          textTheme: TextTheme(
              //设置Material的默认字体样式
              body1: TextStyle(color: Color(0xFF888888), fontSize: 16.0)),
          iconTheme: IconThemeData(
            color: Color(ThemeColor),
            size: 35.0,
          )),
      home: new Scaffold(body: showWeclomePage()),
      onGenerateRoute: Application.router.generator,
    );
  }

  showWeclomePage() {
    //TODO sp判断是否进入过欢迎页
    return new AppPage();
  }
}

void main() async {
  //TODO 初始化sp&db&provider
  final provider = new Provider();
  await provider.init(true);
  db = Provider.db;
  runApp(new MyApp());
}
