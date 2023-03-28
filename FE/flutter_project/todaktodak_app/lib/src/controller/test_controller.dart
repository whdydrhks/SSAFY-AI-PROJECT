import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TestController extends GetxController {
  static TestController get to => Get.find();

  RxInt currentIndex = 0.obs;

  @override
  onInit() {
    super.onInit();
  }

  Future<void> changePageIndex() async {
    print('changePageIndex 실행');
    Future.delayed(const Duration(seconds: 1), () {
      currentIndex.value = 5;
    });
  }
}
