import 'dart:math';

import 'package:flutter/cupertino.dart';

class Test {
  var one = int.parse('1');
  var onePointOne = double.parse('1.1');
  String oneAsString = 1.toString();
  String piAsString = 3.1415926.toStringAsFixed(2);

  static const msPerSecond = 1000;

  var s1 = 'Single quotes work well for string literals.';
  var s2 = "Double quotes work just as well.";
  var s3 = 'It\'s easy to escape the string delimiter.';
  var s4 = "It's even easier to use the other delimiter.";

  // 代码中文解释
  var s11 = '使用单引号创建字符串字面量。';
  var s22 = "双引号也可以用于创建字符串字面量。";
  var s33 = '使用单引号创建字符串时可以使用斜杠来转义那些与单引号冲突的字符串：\'。';
  var s44 = "而在双引号中则不需要使用转义与单引号冲突的字符串：'";

  void print1() {
    var s = '字符串插值';
    assert('Dart 有$s，使用起来非常方便。' == 'Dart 有字符串插值，使用起来非常方便。');
    assert('使用${s.substring(3, 5)}表达式也非常方便' == '使用插值表达式也非常方便。');
  }

  void print2() {
    var s1 = '可以拼接'
        '字符串'
        "即便它们不在同一行。";
    assert(s1 == '可以拼接字符串即便它们不在同一行。');

    var s2 = '使用加号 + 运算符' + '也可以达到相同的效果。';
    assert(s2 == '使用加号 + 运算符也可以达到相同的效果。');
  }

  void print3() {
    var s1 = '''
    你可以像这样创建多行字符串
    ''';

    var s2 = """这也是一个多行字符串""";
  }

  void print4() {
    var s = r'在raw字符串中，转义字符串\n会直接输出"\n"而不是转义为换行';
  }

  void print5() {
    const aConstNum = 0;
    const aConstBool = true;
    const aConstString = 'a constant string';

    var aNum = 0;
    var aBool = true;
    var aString = 'a string';
    const aConstList = [1, 2, 3];

    const validConstString = '$aConstNum $aConstBool $aConstString';
    //const invalidConstString = '$aNum $aBool $aString $aConstList';
  }

  void print6() {
    var list = [1, 2, 3];
    //这里Dart推断出list的类型为List<int>

    var s1 = list.length == 3;
    var s2 = list[1] == 2;

    list[1] = 1;

    var constantList = const [1, 2, 3];
    constantList[1] = 1; // 取消注释将导致出错 (Uncommenting this causes an error.)
  }

  void print7() {
    var list = [1, 2, 3];
    var list2 = [0, ...list];
  }

  void print8() {
    var list;
    var list2 = [0, ...?list];
  }

  void print9() {
    var promoActive = false;
    var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  }

  void print10() {
    var listOfInts = [1, 2, 3];
    var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  }

  void print11() {
    var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
    //Dart推断halogens变量是一个Set<String>类型的集合
  }

  void print12() {
    var names = <String>{}; //类型+{}的形式创建Set。
    Set<String> name2s = {}; //声明类型变量的形式创建Set(This works, too).
    var name3s = {}; //这样的形式将创建一个Map而不是Set。
  }

  void print13() {
    var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};

    var elements = <String>{};
    elements.add('fluorine');
    elements.addAll(halogens);
  }

  void print14() {
    final constantSet = const {
      'fluorine',
      'chlorine',
      'bromine',
      'iodine',
      'astatine',
    };
    //constantSet.add('helium'); // 取消注释将导致出错 (Uncommenting this causes an error).
  }

  void print15() {
    var gifts = {
      'first': 'partridge',
      'second': 'turtledoves',
      'fifth': 'golden rings'
    };

    var nobleGases = {2: 'heliun', 10: 'neon', 18: 'argon'};
  }

  void print16() {
    var gifts = Map();
    gifts['first'] = 'partridge';
    gifts['second'] = 'turtledoves';
    gifts['fifth'] = 'golden rings';

    var nobleGases = Map();
    nobleGases[2] = 'heliun';
    nobleGases[10] = 'neon';
    nobleGases[18] = 'argon';
  }

  void print17() {
    var gifts = {'first': 'partridge'};
    gifts['fourth'] = 'calling birds'; // 添加键值对 (Add a key-value pair)

    var b1 = gifts['first'] == 'partridge'; //获取一个值

    var b2 = gifts['fifth'] == null; //检索不到会返回null

    var b3 = gifts.length; //获取键值对的数量
  }

  void print18() {
    final constanMap = const {
      2: 'helium',
      10: 'neon',
      18: 'argon',
    };
    // constanMap[2] = 'Helium';
  }

  void printElement(int element) {
    print(element);
  }

  void print19() {
    var list = [1, 2, 3];
    list.forEach(printElement);
  }

  void print20() {
    var loudify = (msg) => '!!!${msg.toUpperCase()}!!!';
    var b = loudify('hello') == '!!!HELLO!!!';
  }

  void print21() {
    var list = ['apples', 'bananas', 'oranges'];
    list.forEach((item) {
      print('${list.indexOf(item)}: $item');
    });
  }

  void print22() {
    var list = ['apples', 'bananas', 'oranges'];
    list.forEach((item) => print('${list.indexOf(item)}: $item'));
  }

  bool topLevel = true;

  void print23() {
    var insideMain = true;

    void myFunction() {
      var insideFunction = true;

      void nestedFunction() {
        var insideNestedFunction = true;

        print('$topLevel $insideMain $insideFunction $insideNestedFunction');
      }
    }
  }

  /// 返回一个将 [addBy] 添加到该函数参数的函数。
  /// Returns a function that adds [addBy] to the
  /// function's argument.
  Function makeAdder(num addBy) {
    return (num i) => addBy + i;
  }

  void print24() {
    var add2 = makeAdder(2);
    var add4 = makeAdder(4);

    var b1 = add2(3) == 5;
    var b2 = add4(3) == 7;
  }

  var _nobleGases = {2: 'heliun', 10: 'neon', 18: 'argon'};

  bool isNoble(int atomicNumber) {
    return _nobleGases[atomicNumber] != null;
  }

  bool isNoble1(atomicNumber) {
    enableFlags(hidden: false);
    enableFlags(bold: false, hidden: true);
    return _nobleGases[atomicNumber] != null;
  }

  bool isNoble2(int atomicNumber) => _nobleGases[atomicNumber] != null;

  void foo() {} //定义顶层函数

  void print25() {
    var x;

    // 比较顶层函数是否相等
    x = foo;
    print('${foo == x}');

    //比较静态方法是否相等
    x = A.bar;
    print('${A.bar == x}');

    //比较实例方法是否相等
    var v = A();
    var w = A();
    var y = w;
    x = w.baz;

    // 这两个闭包引用了相同的实例对象，因此它们相等
    print('${y.baz == x}');
    // 这两个闭包引用了不同的实例对象，因此它们不相等
    print('${v.baz != w.baz}');
  }

  var b;

  void print26() {
    var value = 2;
    var a = value;
    //当且仅当b为null时才赋值
    b ??= value;
  }

  void print27() {
    var message = StringBuffer('Dart is fun');
    for (var i = 0; i < 5; i++) {
      message.write('!');
    }
  }

  void print28() {
    var callbacks = [];
    for (var i = 0; i < 2; i++) {
      callbacks.add(() => print(i));
    }
    callbacks.forEach((c) => c());
  }

  void print29() {
    var collection = [1, 2, 3];
    for (var x in collection) {
      print(x);
    }
  }

  void print30() {
    var command = 'CLOSED';
    switch (command) {
      case 'CLOSED': // case 语句为空时的 fall-through 形式。
        continue newClosed;
      // 继续执行标签为 nowClosed 的 case 子句。

      newClosed:
      case 'NEW_CLOSED':
        // case 条件值为 CLOSED 和 NOW_CLOSED 时均会执行该语句。
        break;
    }
  }

  void print31() {
    try {
      doSomething();
    } on OutOfMemoryError {
      //处理指定异常

    } on Exception catch (e) {
      // 其它类型的异常
      print('Unknown exception: $e');
    } catch (e, s) {
      // 不指定类型，处理其它全部
      print('Something really unknown: $e');
      print('Stack trace:\n $s');
    }
  }

  void misbehave() {
    try {
      dynamic foo = true;
      print(foo++); // 运行时错误
    } catch (e) {
      print('misbehave() partially handled ${e.runtimeType}.');
      rethrow; // 允许调用者查看异常。
    }
  }

  void print33() {
    try {
      misbehave();
    } catch (e) {
      print('print33() finished handling ${e.runtimeType}.');
    }
  }

  void print34() {
    var p1 = Point(2, 3);
    var p2 = new Point(2, 3);

    var p3 = const ImmutablePoint(2, 3);
  }

  void print35() {
    //这里有很多const关键字
    const pointAndLine = const {
      'point': const [const ImmutablePoint(0, 0)],
      'line': const [const ImmutablePoint(1, 10), const ImmutablePoint(-2, 11)]
    };

    const pointAndLine1 = {
      'point': [ImmutablePoint(0, 0)],
      'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)]
    };

    print('The type of a is ${pointAndLine.runtimeType}');
  }

  void print36() {
    var person = Person("11");
    var employee = Employee("22");

    person.eat();
    employee.eat();
  }

  void print37() {
    var logger = Logger('UI');
    logger.log('Button clicked');
  }

  void doSomething() {}
}

class Logger {
  final String name;
  bool mute = false;

  // _cache变量是库私有的，因为在其名字前面有下划线
  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }
}

class Point4 {
  num x, y;

  // 该类的主构造函数
  Point4(this.x, this.y);

  // 委托实现给主构造函数
  Point4.alongXAxis(num x) : this(x, 0);
}

class Person {
  String name;

  Person(this.name);

  void eat() {}
}

class Employee extends Person {
  Employee(String name) : super(name);
}

class ImmutablePoint {
  static final ImmutablePoint origin = const ImmutablePoint(0, 0);

  final num x, y;

  const ImmutablePoint(this.x, this.y);
}

class Point {
  var x; // 声明实例变量 x 并初始化为 null。
  var y; // 声明实例变量 y 并初始化为 null。
  num z = 0; // 声明实例变量 z 并初始化为 0。

  Point(this.x, this.y);
}

class Point2 {
  num x, y;

  Point2(num x, num y) {
    this.x = x;
    this.y = y;
  }
}

class Point3 {
  num x, y;

  Point3(this.x, this.y);

  //命名式构造函数
  Point3.origin() {
    x = 0;
    y = 0;
  }
}

class Point5 {
  num x, y;

  Point5(this.x, this.y);

  num distanceTo(Point4 other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}

class Rectangle {
  num left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  //定义两个计算生产的属性：right和bottom
  num get right => left + width;

  set right(num value) => left = value - width;

  num get bottom => top + height;

  set bottom(num value) => top = value - height;
}

// 该类被声明为抽象的，因此它不能被实例化。
abstract class Doer {
  // 定义实例变量和方法等等...

  void doSomething(); //定义一个抽象方法
}

class EffectiveDoer extends Doer {
  @override
  void doSomething() {
    // TODO: implement doSomething
  }
}

// Person1类的隐式接口中包含greet()方法。
class Person1{
  final _name;

  Person1(this._name);

  String greet(String who) => '你好, $who。 我是$_name';
}

// Person1 接口的一个实现。
class Impostor implements Person1 {
  @override
  get _name => 'null';

  @override
  String greet(String who) => '你好$who。 你知道我是谁吗？';
}

String greetBob(Person1 person) => person.greet('小芳');

class Television {
  void turnOn() {
  }
}

class SmartTelevision extends Television {
  @override
  void turnOn() {
    super.turnOn();
    doSomething();
  }
}

void doSomething() {
}

void main() {
  print(greetBob(Person1('小云')));
  print(greetBob(Impostor()));
}

class A {
  static void bar() {} //定义静态方法
  void baz() {} //定义实例方法
}

void testFunc() {
  enableFlags(bold: false);
  var b1 = say('Bob', 'Howdy') == 'Bob says Howdy';
  var b2 = say('Bob', 'Howdy', 'smoke signal') ==
      'Bob says Howdy with a smoke signal';
}

/// 设置[bolad]和[hidden] flags...
void enableFlags({bool bold, bool hidden}) {}

String say(String from, String msg, [String device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}

String say2(String from, String msg,
    [String device = 'carrier pigeon', String mood]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  if (mood != null) {
    result = '$result (in a $mood mood)';
  }
  return result;
}

void doStuff(
    {List<int> list = const [1, 2, 3],
    Map<String, String> gifts = const {
      'first': 'paper',
      'second': 'cotton',
      'third': 'leather'
    }}) {
  print('list: $list');
  print('gifts: $gifts');
}
