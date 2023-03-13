import 'package:get/get.dart';

class SampleController extends GetxController {
  RxInt _counter = 0.obs;
  RxInt get counter => _counter;

  void increment() {
    _counter++;
  }

  void decrement() {
    _counter--;
  }
}
