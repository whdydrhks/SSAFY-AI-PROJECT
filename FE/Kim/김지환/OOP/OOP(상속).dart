//상속
/*
  상속이면 중요한 개념이다.
  상속은 부모 클래스와 자식클래스로 구분을 할 수 있다.
  부모 클래스의 필드와 기능을 자식클래스에게 물려줄 수 있다.
  하지만, 자식 클래스 안에서의 기능들을 부모 클래스에게는 넘겨 줄 수는 없다. 
  키워드로는 extends를 사용한다. 
  실습 시작한다.
 */

void main() {
  print('------Idol-------');
  Idol blackPink = Idol(team: '블랙핑크', members: ['지수', '로제', '제니', '리사']);
  print(blackPink.team);
  print(blackPink.members);
  blackPink.sayHello();
  blackPink.produce();
  print('------girlGroup-------');
  GirlGroup blackPink2 = GirlGroup(team: '블랙핑크', members: ['지수', '로제', '제니', '리사']);
  print(blackPink2.team);
  print(blackPink2.members);
  blackPink2.sayHello();
  blackPink2.produce();
  blackPink2.sayGirl();
  print('-----boyGroup-------');
  BoyGroup bigbang= BoyGroup(team: '빅뱅', members: ['지드래곤', '태양']);
  print(bigbang.team);
  print(bigbang.members);
  bigbang.sayHello();
  bigbang.produce();
  bigbang.sayBoy();
}

class Idol {
  final String team;
  final List<String> members;

  Idol({required this.team, required this.members});

  sayHello() {
    print('안녕하세요 ${this.team} 이라고 합니다. ');
  }

  produce() {
    print('저희 멤버는 ${this.members}가 있습니다.');
  }
}

class GirlGroup extends Idol {
  GirlGroup({required String team, required List<String> members})
      : super(team: team, members: members);

  sayGirl() {
    print('저희 그룹은 여자그룹입니다.');
  }
}

class BoyGroup extends Idol {
  BoyGroup({required String team, required List<String> members})
      : super(team: team, members: members);

  sayBoy() {
    print('저희 그룹은 남자그룹입니다.');
  }
}
