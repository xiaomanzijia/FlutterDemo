import 'package:flutter/cupertino.dart';

class Echo extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  const Echo({Key key, this.text, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}
