import 'package:rxdart/rxdart.dart';

void combineLatest() {
  Rx.combineLatest([
    Stream.value('a'),
    Stream.fromIterable(['b', 'c', 'd'])
  ], (list) => list.join()).listen(print);
}

void combineLatest3() {
  Rx.combineLatest3(Stream.value('a'), Stream.value('b'),
      Stream.fromIterable(['c', 'c']), (a, b, c) => a + b + c).listen(print);
}

void combineLatestList() {
  Rx.combineLatestList([
    Stream.value(1),
    Stream.fromIterable([0, 1, 2])
  ]).listen(print);
}

void concat() {
  Rx.concat(
          [Stream.value(1), Rx.timer(2, Duration(seconds: 1)), Stream.value(3)])
      .listen(print);
}

void concatEager() {
  Rx.concatEager(
          [Stream.value(1), Rx.timer(2, Duration(seconds: 1)), Stream.value(3)])
      .listen(print);
}

void defer() {
  Rx.defer(() => Stream.value(1)).listen(print);
}

void forkJoin() {
  Rx.forkJoin([
    Stream.value('a'),
    Stream.fromIterable(['b', 'c', 'd'])
  ], (list) => list.join(', ')).listen(print);
}

void forkJoin3() {
  Rx.forkJoin3(
      Stream.value('a'),
      Stream.value('b'),
      Stream.fromIterable(['c', 'd']),
      (a, b, c) => a + b + c).listen(print); //prints 'abd'
}

void merge() {
  Rx.merge([Rx.timer(1, Duration(seconds: 1)), Stream.value(2)]).listen(print);
}

void never() {
  Rx.never().listen(print);
}

void race() {
  Rx.race([
    Rx.timer(1, Duration(seconds: 1)),
    Rx.timer(2, Duration(seconds: 2)),
    Rx.timer(3, Duration(seconds: 3))
  ]).listen(print);
}

void range() {
  Rx.range(1, 3).listen(print);
//  Rx.range(3, 1).listen(print);
}

void repeat() {
  Rx.repeat((repeatIndex) => Stream.value('repeatIndex: $repeatIndex'), 5)
      .listen(print);
}

void retry() {
//  Rx.retry(() => Stream.value(1), 5).listen(print);

  Rx.retry(() => Stream.value(1).concatWith([Stream.error(Error())]), 2)
      .listen(print, onError: (e, s) => print(e));
}

void retryWhen() {
//  Rx.retryWhen(() => Stream.fromIterable([1]), (e, s) => throw e).listen(print);
  Rx.retryWhen(
          () => Stream.periodic(Duration(seconds: 1), (int i) => i)
              .map((int i) => i == 2 ? throw 'exception' : i),
          (e, s) => Rx.timer('random value', Duration(milliseconds: 200)))
      .take(4)
      .listen(print);
}

void sequenceEqual() {
  Rx.sequenceEqual(Stream.fromIterable([1, 2, 3, 4, 5]),
      Stream.fromIterable([1, 2, 3, 4, 5])).listen(print);
}

void switchLatest() {
  Rx.switchLatest(Stream.fromIterable([
    Rx.timer('A', Duration(seconds: 2)),
    Rx.timer('B', Duration(seconds: 1)),
    Stream.value('C')
  ])).listen(print);
}

void timer() {
  Rx.timer('hi', Duration(seconds: 1)).listen(print);
}

void zip() {
  Rx.zip([
    Stream.value('Hi '),
    Stream.fromIterable(['Friend', 'Dropped'])
  ], (values) => values.first + values.last).listen(print);
}

void zip3() {
  Rx.zip3(
      Stream.value('a'),
      Stream.value('b'),
      Stream.fromIterable(['c', 'dropped']),
      (a, b, c) => a + b + c).listen(print);
}

void main() {
  zip3();
}
