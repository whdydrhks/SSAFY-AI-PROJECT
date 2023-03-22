import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Timer? _timer;
  final RxBool isLoading = true.obs;
  final storage = const FlutterSecureStorage();

  @override
  void onInit() {
    loading();
    super.onInit();
  }

  //여기서 storage에 유저 정보가 있다면 calendarpage로
  //유저 정보가 없다면 registerpage로
  void loading() async {
    Map<String, String> test = await storage.readAll();

    _timer = Timer.periodic(const Duration(microseconds: 1), (timer) {
      if (timer.tick == 2000) {
        if (test.isNotEmpty) {
          Get.snackbar("환영", "안녕하세요 토닥토닥입니다.");
          Get.offNamed("/dashboard");
          timer.cancel();
        } else {
          Get.offNamed("/register");
          timer.cancel();
        }
      }
    });
  }
}
