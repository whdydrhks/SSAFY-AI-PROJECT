//클래스와 인스턴스

/*
 클래스와 인스턴스를 쉽게 설명하자면 
  클래스는 설계서라고 생각을 하면되고 인스턴스는 설계서를 가지고 구체화 혹은 실체화 하는 방식이라고 생각을 하면된다.  
 */

void main() {
  Person person = const Person('김지환', 28);

  print(person.name);
  print(person.age);

  // 아래와 같이 값을 변경할 수 있다? 답은 없다. 우리는 한 번 인스턴스한 값을 변경하지 않도록 하기 위해 final을 선언했다. 
  //  person.name = "소지섭";
  person.greeting();
}

class Person {
  //final 변수 타입으로 선언 했을 String 이나 int를 지워도 무방하다. 나는 개인적으로 이 변수가 어떠한 타입으로 선언을 해야하는지 직관적으로 보이고 싶어서 선언하고 싶다.
  // 이 방식은 좀 케바케인 것 같다.
  final String name;
  final int age;

  const Person(this.name, this.age);
  // 이 함수는 리턴 값이 없는 void 형식의 함수형이다 함수이름 앞에 void를 붙여도 되고 안해도 된다.
  greeting() {
    print('안녕하세요 저는 ${this.name}이고 ${this.age} 살 입니다.');
  }
}

// 클래스와 인스턴스를 사용할 때 알아두어야할 점은 한 번 인스턴스를 했다고 가정하면 이 인스턴스를 바꾸게 하지 않게 하고 싶다.
// 이럴 때 필드 변수타입에 final를 붙어야 한다.
// 그런데  const는 가능할까?
// 그렇지 않다 왜? const 상수 타입은 값이 빌드 시에 나타낼 수 있는 타입이다. 이게 무슨말이냐? 이 값이 무슨 값인지 정확히 알아야 사용할 수 있다.
// 예를 들어 const name = "김지환"이라고 하면 빌드 시에 나타낼 수 있고 바로 이 값이 "김지환"이라는 것을 알 수 있다.
// 하지만 const time = DateTime().now(); 이것은 어떤 값인지 예상할 수 있을까? 그렇지 않다.
// 결국  const는 값이 예상을 할 수 있을 때 사용하는 상수 타입이다.
