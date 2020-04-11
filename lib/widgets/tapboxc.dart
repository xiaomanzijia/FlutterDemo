import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParentWidgetC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ParentWidgetCState();
  }
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    print("_handleTapboxChanged:$newValue");
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapBoxC(active: _active, onChanged: _handleTapboxChanged),
    );
  }
}

class TapBoxC extends StatefulWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  TapBoxC({Key key, this.active, this.onChanged}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TapBoxCState();
  }
}

class TapBoxCState extends State<TapBoxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    print("_handleTapDown");
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    print("_handleTapUp");
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    print("_handleTapCancel");
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    print("_handleTap");
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        child: Center(
          child: Text(
            widget.active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
            color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
            border: _highlight
                ? Border.all(color: Colors.teal[700], width: 10.0)
                : null),
      ),
    );
  }
}
