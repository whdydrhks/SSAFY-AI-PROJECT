import 'dart:async';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/config/message.dart';
import 'package:test_app/src/services/auth/auth_services.dart';

import '../../components/analysis/feel_relation_bar_chart.dart';

class SplashController extends GetxController {
  Timer? _timer;
  final RxBool isLoading = true.obs;
  final storage = const FlutterSecureStorage();
  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  String _andriodUniqueId = "";

  @override
  void onInit() {
    loading();
    super.onInit();
  }

  //여기서 storage에 유저 정보가 있다면 calendarpage로
  //유저 정보가 없다면 registerpage로
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

  void loading() async {
    final userNickname = await storage.read(key: "userNickname");
    final userDevice = await storage.read(key: "userDevice");
    final test = await storage.read(key: "accessToken");
    // 만약 스토리지에 유저 정보가 있다면 로그인을 해준다.
    if (userNickname != null && userDevice != null) {
      print('userNickname $userNickname userDevice $userDevice');
      try {
        var dio = await AuthServices().authDio();
        final response = await dio.post(
          '/user/login',
          data: {
            "userNickname": userNickname,
            "userDevice": userDevice,
          },
        );
        print(response);
        if (response.data["state"] == 200) {
          print("있어? $userNickname $userDevice");
          Get.offNamed("/app");
          Get.snackbar("", "",
              titleText: Message.title("성공"),
              messageText: Message.message(response.data["message"]));
          final accessToken = response.data["data"]["accessToken"];
          final refreshToken = response.data["data"]["refreshToken"];
          final refreshTokenExpirationTime =
              response.data["data"]["refreshTokenExpirationTime"];
          await initPlatform();
          // 유저 정보 업데이트
          await updateUserInfo(
            userNickname,
            _andriodUniqueId,
            accessToken,
            refreshToken,
            refreshTokenExpirationTime,
          );
        }
      } on DioError catch (e) {
        logger.e(e.response?.statusCode);
        logger.e(e.response?.data);
        logger.e(e.message);
      }
    } else {
      Get.offNamed("/register");
    }
  }

// 스토리지에 유저 정보 업데이트
  updateUserInfo(
    String userNickname,
    String userDevice,
    String accessToken,
    String refreshToken,
    String refreshTokenExpirationTime,
  ) async {
    storage.write(key: "userNickname", value: userNickname);
    storage.write(key: "userDevice", value: userDevice);
    storage.write(key: "accessToken", value: accessToken);
    storage.write(key: "refreshToken", value: refreshToken);
    storage.write(
      key: "refreshTokenExpirationTime",
      value: refreshTokenExpirationTime,
    );
  }
}
