import 'package:flutter_app_demo/fluttergo/utils/sql.dart';

abstract class CatInterface {
  int get id;

  //类目名称
  String get name;

  //描述
  String get desc;

  //第几级类目，默认1
  int get depth;

  //父类目id，没有为 0
  int get parentId;
}

class Cat implements CatInterface {
  int id;
  String name;
  String desc;
  int depth;
  int parentId;

  Cat({this.id, this.name, this.desc, this.depth, this.parentId});

  Cat.formJSON(Map json)
      : id = json['id'],
        name = json['name'],
        desc = json['desc'],
        depth = json['depth'],
        parentId = json['parentId'];

  @override
  String toString() {
    return 'Cat{name: $name}';
  }

  Map toMap() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'depth': depth,
      'parentId': parentId
    };
  }

  Map toSqlConditon() {
    Map _map = this.toMap();
    Map condition = {};
    _map.forEach((k, value) {
      if (value != null) {
        condition[k] = value;
      }
    });

    if (condition.isEmpty) return {};

    return condition;
  }
}

class CatControlModel {
  final String table = 'cat';
  Sql sql;

  CatControlModel() {
    sql = Sql.setTab(table);
  }

  // 获取Cat不同深度与parent的列表
  Future<List<Cat>> getList([Cat cat]) async {
    if (cat == null) {
      cat = new Cat(depth: 1, parentId: 0);
    }
    print("cat in getList ${cat.toMap()}");
    List listJson = await sql.getByCondition(conditions: cat.toSqlConditon());
    List<Cat> cats = listJson.map((json) {
      return new Cat.formJSON(json);
    }).toList();
    return cats;
  }
}
