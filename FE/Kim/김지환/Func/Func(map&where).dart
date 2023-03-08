//map이란 형 변환이다.
// 리스트에서 set으로 set에서 리스트로 리스트에서 Map으로 형변환이 가능하다.

void main() {
  //리스트 - Map parsing

  List<String> movies = ['아이언맨', '스파이더맨', '토르'];
  print(movies);

  final newMovieMap = movies.asMap();

  print(newMovieMap);

  //리스트 안에 있는 내용을 좀 변형 시키고 싶다. 각 요소앞에 어벤져스라고 붙혀보자 map() 활용한다.
  // map() 메서드로 통하여 내용을 변형시키고 난 후 새로운 리스트로 만들어준다.

  final newMovies = movies.map((e) => '어벤져스 $e').toList();

  print(newMovies);

  //Map map()활용

  Map<String, String> movieMap = {
    'IronMan': '아이언맨',
    'SpiderMan': '스파이더맨',
    'Thor': '토르'
  };

  //Map에서의 형 변환을 해주기 위해서는 MapEntry를 활용해야한다.
  final newMovieMap2 =
      movieMap.map((key, value) => MapEntry('Avengers $key', '에번져스 $value'));
  print(newMovieMap2);

  //where이란 검색 조건에 맞게 필터링을 하여 새로운 Collection을 반환해준다.
  final parsedList = movies.where((element) => element == '아이언맨').toList();
  print(parsedList);
}
