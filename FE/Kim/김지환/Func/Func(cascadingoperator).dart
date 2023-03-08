void main() {
  //cascading operator 
  List<int> numbers1 = [1, 2, 3, 4];
  List<int> numbers2 = [5, 6, 7, 8];

  print(numbers1);
  print(numbers2);

  print([...numbers1] + [...numbers2]);
}
