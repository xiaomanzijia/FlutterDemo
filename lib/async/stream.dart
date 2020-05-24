

import 'dart:async';

/// 将连续的字符串Stream拆分为行。
///
/// 输入的字符串来自于源Stream并以较小的chunk块提供。
Stream<String> lines(Stream<String> source) async* {
  // 存储从上一个数据块中分离出的字符串行。
  var partial = '';
  // 等到新的数据块可用时开始处理。
  await for (var chunk in source) {
    var lines = chunk.split('\n');
    lines[0] = partial + lines[0];// 追加拼接行。
    partial = lines.removeLast();// 删除剩余不完整的行。
    for (var line in lines) {
      yield line;// 将分离的每个字符串行添加至输出 Stream。
    }
  }
  // 最后如果最终的字符串行不为空则将其添加至输出流。
  if (partial.isNotEmpty) yield partial;
}

Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  await for (var value in stream) {
    sum += value;
  }
  return sum;
}

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i ++) {
    yield i;
  }
}

Iterable<int> foo2() sync* {
  print('foo2 start');
  for (int i = 0; i < 3; i ++) {
    print('运行了foo2, 当前index: $i');
    yield i;
  }
  print('foo2 stop');
}

void main() async {
//  var stream = countStream(10);
//  var sum = await sumStream(stream);
//  print(sum);

//  var b = foo2().iterator;
//  b.moveNext();
//  b.moveNext();
//  b.moveNext();
//  b.moveNext();

  var counterStream =
      Stream<int>.periodic(Duration(seconds: 1), (x) => x).take(15);
  var doubleCounterStream = counterStream.map((int x) => x * 2);
  doubleCounterStream.forEach(print);

  var counterStream1 = Stream<int>.periodic(Duration(seconds: 1), (x) => x).where((int x) => x.isEven)
  .expand((var x) => [x, x])
  .take(5);
  counterStream1.forEach(print);
}

void test1() {
  print('main #1 of 2');
  scheduleMicrotask(() => print('microtst #1 of 2'));

  Future.delayed(Duration(seconds: 1), () => print('future #1 (delayed)'));

  Future(() => print('future #2 of 3'));
  Future(() => print('future #3 of 3'));

  scheduleMicrotask(() => print('microtask #2 of 2'));

  print('main #2 of 2');
}

void test2() {
  print('main #1 of 2');
  scheduleMicrotask(() => print('microtask #1 of 3'));

  Future.delayed(Duration(seconds:1),
          () => print('future #1 (delayed)'));

  Future(() => print('future #2 of 4'))
      .then((_) => print('future #2a'))
      .then((_) {
    print('future #2b');
    scheduleMicrotask(() => print('microtask #0 (from future #2b)'));
  })
      .then((_) => print('future #2c'));

  scheduleMicrotask(() => print('microtask #2 of 3'));

  Future(() => print('future #3 of 4'))
      .then((_) => Future(
          () => print('future #3a (a new future)')))
      .then((_) => print('future #3b'));

  Future(() => print('future #4 of 4'));
  scheduleMicrotask(() => print('microtask #3 of 3'));
  print('main #2 of 2');
}