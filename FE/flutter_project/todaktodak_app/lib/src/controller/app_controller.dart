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

  // 작성 페이지 튜토리얼 보여줄 지 여부에 필요한 데이터
  bool isSignUpUser = false;
  bool isShowTutorial = true;

  void changePageIndex(int index) {
    currentIndex(index);
  }

  @override
  onInit() {
    
    super.onInit();
  }

}
