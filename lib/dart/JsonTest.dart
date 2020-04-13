import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'JsonTest.g.dart';

void test1() {
  String jsonStr = """[{"name":"Jack"},{"email":"Rose"}]""";
  List items = json.decode(jsonStr);
  print(items[0]["name"]);
}

void test2() {
  String jsonStr = """{"name":"Jack","email":"Rose"}""";
  Map userMap = json.decode(jsonStr);
  var user = User.fromJson(userMap);
  print(user.name);

  String jsonOutStr = json.encode(user);
  print(jsonOutStr);
}

void main() {
//  test1();

  test2();
}


class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'name': name, 'email': email};
}


///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class UserModel {
  final String name;
  final String email;

  UserModel(this.name, this.email);

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
