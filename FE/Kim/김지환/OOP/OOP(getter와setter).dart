//getter와 setter

// 우리는 한 번 인스턴스화 한 것을 변경하지 않도록 하고 싶다고 했다.
// dart에서의 클래스는 getter와 setter의 기능을 제공한다.
// 그냥 알아두는 것이 좋다.
// setter는 잘 사용하지 않고 getter는 하나의 값을 추출 하고 싶을 때 사용할 수 있다.
void main() {
  BlackPink blackPink = BlackPink(team: '블랙핑크', members: ['리사', '로제', '제니', '지수']);

  print(blackPink);
  print(blackPink.team);
  print(blackPink.members);
  blackPink.sayHello();
  blackPink.produce();
  print(blackPink.firstMember);
  blackPink.changeFirstMember('안녕');
  print(blackPink.firstMember);
}

//setter를 실습하기 위해서 여기에서는 final 및 const를 사용하지 않겠다.
class BlackPink {
  String team;
  List<String> members;

  BlackPink({required  this.team, required this.members});

  String get firstMember {
    return members[0];
  }

  void changeFirstMember(String name) {
    members[0] = name;
  }

  sayHello() {
    print('안녕하세요 저희는 ${this.team} 입니다.');
  }

  produce() {
    print("저희멤버는 ${this.members}가 있습니다.");
  }
}
