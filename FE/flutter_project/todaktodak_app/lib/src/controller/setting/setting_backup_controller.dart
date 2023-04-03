import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/config/message.dart';
import 'package:test_app/src/services/diary/diary_services.dart';

class SettingBackupController extends GetxController {
  static SettingBackupController get to => Get.find();
  final formKey = GlobalKey<FormState>();
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
    if (password.value.isEmpty) {
      Get.snackbar("", "",
          titleText: Message.title("오류"),
          messageText: Message.message("비밀번호를 입력해주세요"));
    } else if (passwordConfirm.value.isEmpty) {
      Get.snackbar("", "",
          titleText: Message.title("오류"),
          messageText: Message.message("비밀번호 다시 입력란에 입력해주세요"));
    } else if (password.value != passwordConfirm.value) {
      Get.snackbar("", "",
          titleText: Message.title("오류"),
          messageText: Message.message("비밀번호가 같지않습니다."));
    } else {
      final accessToken = await storage.read(key: "accessToken");
      final refreshToken = await storage.read(key: "refreshToken");

      print(password.value);
      final refreshTokenExpirationTime =
          await storage.read(key: "refreshTokenExpirationTime");
      var dio = await DiaryServices()
          .backupDio(accessToken: accessToken, refreshToken: refreshToken);

      final response =
          await dio.put("/user/backup", data: {"newPassword": password.value});

      print(response);

      if (response.data["state"] == 401) {
        final newToken = await DiaryServices()
            .tokenRefresh(accessToken: accessToken, refreshToken: refreshToken);
        final request = response.requestOptions
          ..headers['Authorization'] = 'Bearer $newToken';
        await dio.request(request.path,
            options: Options(headers: request.headers));
      } else if (response.data["state"] == 200) {
        Get.back();
        Get.snackbar("", "",
            titleText: Message.title("성공"),
            messageText: Message.message("백업에 성공했습니다."));
      }
    }
  }
}
