import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/components/analysis/feel_relation_bar_chart.dart';
import 'package:test_app/src/config/message.dart';
import 'package:test_app/src/model/auth/register_user.dart';
import 'package:test_app/src/services/auth/auth_services.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  late TextEditingController nicknameController;
  final RxBool ischecked = false.obs;
  final RxBool isAgree = false.obs;
  final RxString nickName = "".obs;
  final RxBool isClicked = false.obs;
  final RxString validate = "".obs;
  final RxBool isvalidate = false.obs;
  String _andriodUniqueId = "";
  final RegisterUser _user = RegisterUser();
  static const storage = FlutterSecureStorage();
  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  bool change = false;

  @override
  void onInit() {
    nicknameController = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    nicknameController.dispose();
    super.onClose();
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

  onChangeNickname(String value) {
    nickName(value);
  }

  String? onCheckbox(bool check) {
    if (check == false) {
      return "기기정보 약관 동의 해주세요";
    }
    return null;
  }

  changeCheck(checked) {
    ischecked(checked);
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

  register() async {
    await initPlatform();

    _andriodUniqueId = _deviceData["androidId"];

    _user.userNickname = nickName.value;

    _user.userDevice = _andriodUniqueId;
    try {
      if (nickName.value.isEmpty) {
        Get.snackbar("오류", "닉네임을 입력해주세요");
      } else {
        if (ischecked.isFalse) {
          Get.snackbar("오류", "기기고유정보 사용에 동의해주세요");
        } else {
          print("유저 정보 $_user");
          var dio = await AuthServices().authDio();
          final response = await dio.post('/user/sign-up', data: {
            "userNickname": nickName.value,
            "userDevice": _andriodUniqueId
          });
          if (response.data["state"] == 200) {
            print("응답 $response");
            final accessToken = response.data["data"]["accessToken"];
            final refreshToken = response.data["data"]["refreshToken"];
            final refreshTokenExpirationTime =
                response.data["data"]["refreshTokenExpirationTime"];
            final nickname = nickName.value;
            final userDevice = _andriodUniqueId;

            await savedUserInfo(accessToken, refreshToken, nickname, userDevice,
                refreshTokenExpirationTime.toString());

            isvalidate(false);
            Get.offNamed("/app");
            Get.snackbar("", "",
                titleText: Message.title("성공"),
                messageText: Message.message(response.data["message"]));
          } else if (response.data["state"] == 400) {
            isvalidate(true);
            Get.snackbar("", "",
                titleText: Message.title("실패"),
                messageText: Message.message(response.data["message"]));
          }
        }
      }
    } on DioError catch (e) {
      logger.e(e.response?.statusCode);
      logger.e(e.response?.data);
      logger.e(e.message);
    }
  }
}
