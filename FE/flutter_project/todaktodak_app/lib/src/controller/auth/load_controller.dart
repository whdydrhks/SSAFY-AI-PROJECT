import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/components/analysis/feel_relation_bar_chart.dart';
import 'package:test_app/src/config/message.dart';
import 'package:test_app/src/services/auth/auth_services.dart';

class LoadController extends GetxController {
  static LoadController get to => Get.find();
  final GlobalKey<FormState> loadFormKey = GlobalKey<FormState>();
  late TextEditingController nicknameController;
  late TextEditingController passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();
  final RxBool ischecked = false.obs;
  final RxBool isAgree = false.obs;
  final RxString nickName = "".obs;
  final RxString password = "".obs;
  final RxBool testBool = false.obs;
  String _andriodUniqueId = "";
  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  bool change = false;

  @override
  void onInit() {
    nicknameController = TextEditingController();
    super.onInit();
  }

  Future<void> initPlatform() async {
    Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfo.androidInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{'Error': '플랫폼 가져오는데 실패하였습니다.'};
    }

    _deviceData = deviceData;
    _andriodUniqueId = _deviceData["androidId"];
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'androidId': build.androidId,
    };
  }

  changeCheck(checked) {
    ischecked(checked);
  }

  changeNickname(String nick) {
    nickName(nick);
  }

  changePassword(String pass) {
    password(pass);
  }

  test() {
    change = !change;
    isAgree(change);
    print(isAgree);
  }

  savedUserInfo(var accessToken, var refreshToken, var nickname, var userDevice,
      var refreshTokenExpirationTime) {
    storage.write(key: "accessToken", value: accessToken);
    storage.write(key: "refreshToken", value: refreshToken);
    storage.write(
        key: "refreshTokenExpirationTime", value: refreshTokenExpirationTime);
    storage.write(key: "userNickname", value: nickname);
    storage.write(key: "userDevice", value: userDevice);
  }

  loadup() async {
    if (nickName.value.isEmpty) {
      testBool(true);
      Get.snackbar("오류", "닉네임을 입력해주세요");
    } else if (password.value.isEmpty) {
      testBool(false);
      Get.snackbar("오류", "비밀번호를 입력해주세요");
    } else {
      testBool(false);
      await initPlatform();
      try {
        var dio = await AuthServices().authDio();
        final response = await dio.put('/user/load', data: {
          "userNickname": nickName.value,
          "userPassword": password.value,
          "userDevice": _andriodUniqueId
        });

        if (response.data["state"] == 200) {
          final accessToken = response.data["data"]["accessToken"];
          final refreshToken = response.data["data"]["refreshToken"];
          final refreshTokenExpirationTime =
              response.data["data"]["refreshTokenExpirationTime"];
          final nickname = nickName.value;
          final userDevice = _andriodUniqueId;

          savedUserInfo(accessToken, refreshToken, nickname, userDevice,
              refreshTokenExpirationTime.toString());

          Get.offNamed("/app");
          Get.snackbar("", "",
              titleText: Message.title("성공"),
              messageText: Message.message(response.data["message"]));
        } else if (response.data["state"] == 400) {
          Get.snackbar("", "",
              titleText: Message.title("실패"),
              messageText: Message.message(response.data["message"]));
        }
      } on DioError catch (e) {
        logger.e(e.response?.statusCode);
        logger.e(e.response?.data);
        logger.e(e.message);
      }
    }
  }
}
