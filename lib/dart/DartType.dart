

void printInts(List<int> a) => print(a);

class Animal{
  void chase(Animal a){

  }

  Animal get parent => Animal();
}

class HoneyBadger extends Animal {
  void chase(Object a) {
  }

  HoneyBadger get parent => HoneyBadger();
}

class Mouse extends Animal {

}

class Cat extends Animal {
  @override
  void chase(Animal a) {
  }
}

class Alligator extends Animal {

}


class Lion extends Cat {

}

class MaineCoon extends Cat {

}

void test1() {
}


void main() {
  var list = <int>[];
  list.add(1);
  list.add(2);
  printInts(list);

  Animal a = Cat();
  a.chase(Alligator());

  List<dynamic> bar = <dynamic>[Alligator(), Cat()];

  List<Cat> myCats = List<MaineCoon>();
  List<Cat> myCats1 = List<Animal>();
  myCats1.add(Lion());
  myCats1.add(MaineCoon());
}
