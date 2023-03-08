//generic
/*
  제네릭은 타입을 하나로 고정적으로 두지 않고 다양한 외부타입으로 넣고 싶을 때 사용한다. 
  자바랑 비슷하다고 보면됨. 
 */

void main() {
  Test test = Test('김지환', 28);

  print(test.name);
  print(test.age);
  test.greeting();

  print(test.name.runtimeType);
  print(test.age.runtimeType);
}

class Test<Y, X> {
  final Y name;
  final X age;

  const Test(this.name, this.age);

  greeting() {
    print('안녕하세요 ${this.name}이고 ${this.age} 살 입니다.');
  }
}
