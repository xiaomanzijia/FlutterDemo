import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FocusTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FocusTestRouteState();
  }
}

class _FocusTestRouteState extends State<FocusTestRoute> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidate: true, //开启自动校验
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "用户名和邮箱",
                    icon: Icon(Icons.person)),
                //校验用户名
                validator: (value) {
                  return value.trim().length > 0 ? null : "用户名不能为空";
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "您的登录密码",
                    icon: Icon(Icons.lock)),
                obscureText: true,
                //校验密码
                validator: (value) {
                  return value.trim().length > 5 ? null : "密码不能少于6位";
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("登录"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          //在这里不能通过此方式获取FormState，context不对
                          //print(From.of(context));

                          //通过_formKey.currentState 获取FormState后，
                          //调用validate()方法校验用户密码是否合法，校验通过后再提交数据
                          if ((_formKey.currentState as FormState).validate()) {
                            //验证通过提交数据
                            print("验证通过提交数据");
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              Builder(
                builder: (context) {
                  return Column(
                    children: <Widget>[
                      RaisedButton(
                        child: Text("移动焦点"),
                        onPressed: () {},
                      ),
                      RaisedButton(
                        child: Text("隐藏键盘"),
                        onPressed: () {},
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ));
  }
}
