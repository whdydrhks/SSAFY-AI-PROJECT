import 'package:get/get.dart';

class SettingController extends GetxController {
  static SettingController get to => Get.find();

  RxInt count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initFc();
  }

  void initFc() {
    count(27);
  }
  
  void test() {
    print('test');
  }

}