import 'dart:collection';

import 'package:flutter/material.dart';

import 'contact_picker.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State createState() {
    return new _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final ContactPicker _contactPicker = new ContactPicker();
  Contact _contact;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
      appBar: new AppBar(
        title: new Text('Plugin example app'),
      ),
      body: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new MaterialButton(
                color: Colors.blue,
                child: new Text('CLICK ME'),
                onPressed: () async {
//                  Contact contact = await _contactPicker.selectContact();
//                  setState(() {
//                    _contact = contact;
//                  });
                  int initIndex = 0;
                  List list = [1, 2, 3, 4, 5, 6];
                  Map<int, String> map;
                  map = HashMap.fromIterable(list,
                      key: (data) => data, value: (data) => 'loading');
                  print('map:$map');

                  var previousList = list.sublist(0, initIndex).reversed.toList();
                  var nextList = list.sublist(initIndex, list.length);
                  print('previousList:$previousList  nextList:$nextList');

                  request(previousList, map);
                  request(nextList, map);
                }),
            new Text(
                _contact == null ? 'No Contact selected.' : _contact.toString())
          ],
        ),
      ),
    ));
  }

  Future request(List list, Map<int, String> map) async {
    if(list?.isEmpty ?? true) return null;
    do {
      await Future.delayed(Duration(seconds: 1), () {
        print('data:${list[0]}');
        map[list[0]] = '${list[0]}';
        print('map:$map');
        list.removeAt(0);
      });
    } while (list.isNotEmpty);
  }
}
