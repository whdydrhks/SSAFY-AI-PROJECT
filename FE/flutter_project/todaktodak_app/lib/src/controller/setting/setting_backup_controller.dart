import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/services/diary/diary_services.dart';

class SettingBackupController extends GetxController {
  static SettingBackupController get to => Get.find();
  final TextEditingController passWordController = TextEditingController();
  final TextEditingController passWordConfirmController =
      TextEditingController();

  final RxString password = "".obs;
  final RxString passwordConfirm = "".obs;
  final storage = const FlutterSecureStorage();

  onChangePassword(String value) {
    password(value);
  }

  onChangePasswordConfirm(String value) {
    passwordConfirm(value);
  }

  requestBackup() async {
    final accessToken = await storage.read(key: "accessToken");
    final refreshToken = await storage.read(key: "refreshToken");

    print(password.value);
    final refreshTokenExpirationTime =
        await storage.read(key: "refreshTokenExpirationTime");
    var dio = await DiaryServices()
        .diaryDio(accessToken : accessToken, refreshToken : refreshToken);

    final response =
        await dio.put("/user/backup", data: {"newPassword": password.value});
  }
}
