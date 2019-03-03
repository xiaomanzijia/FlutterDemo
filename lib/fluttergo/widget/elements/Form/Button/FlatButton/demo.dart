import 'package:flutter/material.dart';

class FlatButtonDefault extends StatelessWidget {
  final bool isDisable;

  FlatButtonDefault([this.isDisable = true])
      : assert(isDisable != null),
        super();

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: const Text(
        '默认按钮',
        semanticsLabel: 'FLAT BUTTON 1',
      ),
      onPressed: (isDisable ? () {} : null),
    );
  }
}

class FlatButtonIconDefault extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
