//함수형 프로그래밍
//Collection과 map, where
//reduce, fold
//cascading operator
//클래스 map

void main() {
  //리스트는 순서가 있고 중복이 허용가능하다.
  List<String> movies = ['아이언맨', '스파이더맨', '앤트맨'];
  //새로운 요소 추가
  movies.add('토르');
  print(movies);
  //원하는 값 수정
  movies[0] = '닥터스트레인지';
  print(movies);
  //값 삭제
  movies.remove('스파이더맨');
  print(movies);

  //Map은 key와 value로 한 쌍을 가지고 있다.
  Map<String, String> movieMap = {
    'IronMan': '아이언맨',
    'SpiderMan': '스파이더맨',
    'Thor': '토르'
  };

  print(movieMap);

  //원하는 키값으로 value 추출
  print(movieMap['IronMan']);

  //movieMap이 가지고 있는 키값들을 출력
  //출력을 했을 떄 iterable형식으로 되어있다 이것을 리스트형으로 바꾸고 싶으면 .toList()로 해주면된다.
  print(movieMap.keys.toList());
  print(movieMap.values.toList());

  //Set은 중복이 불가능하다.
  Set<String> movieSet = {'아이언맨', '아이언맨', '토르', '토르'};
  
}
