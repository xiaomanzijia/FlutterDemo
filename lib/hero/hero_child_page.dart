import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/hero/photo_hero.dart';

class HeroChildPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // The blue background emphasizes that it's a new route.
      color: Colors.lightBlueAccent,
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.topLeft,
      child: new PhotoHero(
        photo: 'images/ic_img_default.png',
        width: 100.0,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

}