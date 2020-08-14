abstract class Super {
  void method() {
    print('Super');
  }
}

class MySuper implements Super {
  @override
  void method() {
    print('MySuper');
  }
}

mixin Mixin1 on Super {
  void method1() {
    super.method();
    print('Sub1');
  }

  void method() {
    super.method();
    print('Sub1');
  }
}

mixin Mixin2 on Super {
  void method2() {
    super.method();
    print('Sub2');
  }

  void method() {
    super.method();
    print('Sub2');
  }
}

mixin Mixin3 on Super {
  void method3() {
    super.method();
    print('Sub3');
  }

  void method() {
    super.method();
    print('Sub3');
  }
}

class Client extends MySuper with Mixin1, Mixin3 {
  @override
  void method() {
    super.method();
    print('Client');
  }
}

void main() {
  Client().method();
  Client().method1();
}