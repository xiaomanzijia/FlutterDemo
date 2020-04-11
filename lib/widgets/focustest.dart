import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FocusTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FocusTestRouteState();
  }

}

class _FocusTestRouteState extends State<FocusTestRoute> {

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusScopeNode _focusScopeNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            autofocus: true,
            focusNode: focusNode1,//关联focusNode1
            decoration: InputDecoration(
              labelText: "input1"
            ),
          ),
          TextField(
            focusNode: focusNode2,//关联focusNode2
            decoration: InputDecoration(
              labelText: "input2"
            ),
          ),
          Builder(
            builder: (context) {
              return Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text("移动焦点"),
                    onPressed: () {
                      //将焦点从第一个TextField移到第二个TextField
                      //这是一种写法 FocusScope.of(context).requestFocus(focusNode2);
                      //这是第二种写法
                      if(null == _focusScopeNode) {
                        _focusScopeNode = FocusScope.of(context);
                      }
                      _focusScopeNode.requestFocus(focusNode2);
                    },
                  ),
                  RaisedButton(
                    child: Text("隐藏键盘"),
                    onPressed: () {
                      //当所有编辑框都失去焦点时键盘就会收起
                      focusNode1.unfocus();
                      focusNode2.unfocus();
                    },
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
