void main() {
  List<Map<String, String>> members = [
    {'name': '지수', 'group': '블랙핑크'},
    {'name': '윤보미', 'group': '에이핑크'},
    {'name': '카리나', 'group': '에스파'},
    {'name': '제니', 'group': '블랙핑크'},
    {'name': '정은지', 'group': '에이핑크'},
  ];

  final parsedMebers = members
      .map((e) => Person(name: '${e['name']!}', group: '${e['group']!}'))
      .toList();
  print(parsedMebers);
}

class Person {
  final name;
  final group;

  Person({required this.name, required this.group});

  @override
  String toString() {
    return 'Person(name : ${this.name}), Person(group : ${this.group})';
  }
}
