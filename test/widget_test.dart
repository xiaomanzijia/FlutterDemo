// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_demo/main_demo.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  test('fold', () {
    var list = [1,2,3,4,5];
    var result = list.fold(1, (sum, item) => sum + item);
    print('result:$result');
  });


  test('yushu', () {

    var count = 200;

    var x1 = count / 50;
    var x2 = count ~/ 50;

    var result = (x1 > x2) ? x2 + 1 : max(x2, 1);

    print('x1:$x1   x2:$x2   result:$result');

    var pageList = List.generate(result, (int index) => index + 1);

    print('pageList:$pageList');

    print('${150 ~/ 50}  ${(150 / 50).floor()}');
    print('${156 / 50}  ${(156 / 50).round()}');
    print('${6 ~/ 50}   ${(6 / 50).round()}');
    print('${138 ~/ 50} ${(138 / 50).round()}');
  });

  test('Map To List', () {
    int initIndex = 3;
    List list = [1, 2, 3, 4, 5, 6];
    Map<int, String> map;
    map = HashMap.fromIterable(list,
        key: (data) => data, value: (data) => 'loading');
    print('map:$map');

//    await Future.forEach(list, (data) {
//      Future.delayed(Duration(seconds: 2), () {
//        print('data$data');
//      });
//    });

    var previousList = list.sublist(0, initIndex).reversed.toList();
    var nextList = list.sublist(initIndex, list.length);
    print('previousList:$previousList  nextList:$nextList');


//    request(previousList, map);
//
//    request(nextList, map);
    
    
//    requestDi();

    Future.delayed(Duration(seconds: 1), () {
      print('递归');
    }).then((data) {
      print('递归1');
//    requestDi();
    });

  });
}

void requestDi() {
  Future.delayed(Duration(seconds: 1), () {
    print('递归');
  }).then((data) {
    print('递归1');
//    requestDi();
  });
}

Future request(List previousList, Map<int, String> map) async {
   do {
    await Future.delayed(Duration(seconds: 1), () {
      print('data:${previousList[0]}');
      map[previousList[0]] = '${previousList[0]}';
      print('map:$map');
      previousList.removeAt(0);
    });
  } while (previousList.isNotEmpty);
}
