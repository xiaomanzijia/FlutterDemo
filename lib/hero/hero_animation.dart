import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'hero_child_page.dart';
import 'photo_hero.dart';

Future<void> main() async {
  runApp((MaterialApp(
    home: Scaffold(
      body: HeroAnimation(),
    ),
  )));
}

class HeroAnimation extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Basic Hero Animation'),
      ),
      body: new Center(
        child: new PhotoHero(
          photo: 'images/ic_img_default.png',
          width: 300.0,
          onTap: () {
            Navigator.of(context).push(
                new MaterialPageRoute<Null>(builder: (BuildContext context) {
              return new Scaffold(
                appBar: new AppBar(
                  title: const Text('Flippers Page'),
                ),
                body: HeroChildPage(),
              );
            }));
          },
        ),
      ),
    );
  }
}
