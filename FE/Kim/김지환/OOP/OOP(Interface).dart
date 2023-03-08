//인터페이스
/*
 인터페이스를 사용하면 특정 기능의 구현을 강제할 수 있다.
 즉 이 기능들을 무조건 써라라는 뜻이다. 

 */
void main() {
  //여기서 문제 우리는 인터페이스를 직접적으로 구현을 하지않고 다른 클래스에서 구현을 강제하기 위한 용도로 쓰인다.
  // Interface test = Interface('김지환', 28);

  //그런데 구현이 된다.???
  //이것을 막을 방법이 없을까? 그냥 우리는 설계도의 용도로만 사용하고 싶다.
  //이럴 때 Interface 이름 앞에 abstract 키워드를 붙이면 추상 클래스 용도로 사용할 수 있게 된다.
  // print(test.name);
  // print(test.age);

  Person person = Person('김지환', 28);
  print(person.name);
  print(person.age);

  person.greeting();
}

//인터페이스 정의를 할 때는 클래스를 사용하고
//다른 클래스들이 인터페이스를 사용하기 위해서 implements키워드를 붙인다.
abstract class Interface {
  final String name;
  final int age;

  const Interface(this.name, this.age);

  void greeting() {}
}

class Person implements Interface {
  final String name;
  final int age;

  const Person(this.name, this.age);

  void greeting() {
    print('안녕하세요 ${this.name}이고 ${this.age} 살 입니다. ');
  }
}
