import 'dart:async';

import 'package:get/get.dart';

class SplashController extends GetxController {
  Timer? _timer;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  void loading() {
    print("컨트롤러 주입 완료");
    _timer = Timer.periodic(const Duration(microseconds: 1), (timer) {
      print(timer.tick);
      if (timer.tick == 800) {
        print("멈춰 제발");
        Get.offNamed("/register");
        timer.cancel();
      }
    });
  }
}
