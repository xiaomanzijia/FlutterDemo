import 'package:flutter/material.dart';

class WidgetNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("widget not found"),
      ),
      body: Container(
        child: Text("widget not found"),
      ),
    );
  }
}
