import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TapBoxA extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return _TapboxAState();
  }

}


class _TapboxAState extends State<TapBoxA> {

  bool _active = false;


  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
            color: _active ? Colors.lightGreen[700] : Colors.grey[600]
        ),
      ),
    );
  }

}