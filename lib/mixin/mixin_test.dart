class S {
  fun() => print('A');
}

mixin MA on S {
  fun() {
    super.fun();
    log();
    print('MA');
  }

  log() {
    print('log MA');
  }
}

mixin MB on S {
  fun() {
    super.fun();
    log();
    print('MB');
  }

  log() {
    print('log MB');
  }
}

class A extends S with MA, MB {}
class B extends S with MB, MA {}

void main() {
  var a = A();
  a.fun();
//  var b = B();
//  b.fun();
}