import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  final storage = const FlutterSecureStorage();
  final userId = "";
  var myId = "".obs;

  void changePageIndex(int index) {
    currentIndex(index);
  }

  @override
  onInit() {
    
    super.onInit();
  }

}
