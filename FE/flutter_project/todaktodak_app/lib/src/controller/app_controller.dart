import 'package:get/get.dart';

enum RouteName {
  Calendar,
  Diary,
  Analisys,
  Setting,
}

class AppController extends GetxController {
  static AppController get to => Get.find();
  RxInt currentIndex = 0.obs;

  void changePageIndex(int index) {
    currentIndex(index);
  }


}
