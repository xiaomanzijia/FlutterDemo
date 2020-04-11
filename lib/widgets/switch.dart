import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchAndCheckBoxTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SwitchAndCheckBoxTestRouteState();
  }
}

class _SwitchAndCheckBoxTestRouteState
    extends State<SwitchAndCheckBoxTestRoute> {
  bool _switchSelected = true; //维护单选开关状态
  bool _checkboxSelected = true; //维护复选状态

  TextEditingController _unameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
          value: _switchSelected, //当前状态
          onChanged: (value) {
            //重新构建页面
            setState(() {
              _switchSelected = value;
            });
          },
        ),
        Checkbox(
          value: _checkboxSelected,
          activeColor: Colors.red, //选中时的颜色
          onChanged: (value) {
            setState(() {
              _checkboxSelected = value;
            });
          },
        ),
        TextField(
          autofocus: true,
          decoration: InputDecoration(
            labelText: "用户名",
            hintText: "用户名或邮箱",
            prefixIcon: Icon(Icons.person)
          ),
          controller: _unameController,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "密码",
            hintText: "你的登录密码",
            prefixIcon: Icon(Icons.lock)
          ),
          obscureText: true,
        )
      ],
    );
  }
}
