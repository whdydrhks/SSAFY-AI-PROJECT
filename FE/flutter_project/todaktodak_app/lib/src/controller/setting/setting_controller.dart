import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:test_app/src/services/auth/auth_services.dart';

class SettingController extends GetxController {
  static SettingController get to => Get.find();
  final storage = const FlutterSecureStorage();

  RxInt count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    
  }

  void test() {
    print('test');
  }

  logout() async {
    final accessToken = await storage.read(key: "accessToken");
    final refreshToken = await storage.read(key: "refreshToken");
    var dio = await AuthServices()
        .logoutDio(accessToken, refreshToken);
    final response = await dio.post("/user/logout");
  }
}
