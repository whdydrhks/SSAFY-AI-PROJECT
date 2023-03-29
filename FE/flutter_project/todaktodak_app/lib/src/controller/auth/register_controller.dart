import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/components/analysis/feel_relation_bar_chart.dart';
import 'package:test_app/src/model/auth/register_user.dart';
import 'package:test_app/src/services/auth/auth_services.dart';
import 'package:test_app/src/services/auth/register_services.dart';

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
    // TODO: implement onInit
    nicknameController = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    nicknameController.dispose();
    super.onClose();
  }

  validateNicknameCheck(String nick) {
    //중복체크 api 코드 써야됨
    print("중복체크 api 함수 호출되었습니다.");
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

  String? onNicknameLength(String nick) {
    if (nick.isEmpty) {
      return "닉네임을 입력해주세요";
    } else {
      validateNickname(nick);
      if (isvalidate.value == true) {
        return "중복된 닉네임입니다.";
      }
    }
    return null;
  }

  validateNickname(String nick) async {
    try {
      print('나 중복인지확인해줘!! $nick');
      var data = await RegisterServices().findNickname(nick);
      print(data.state);
      if (data.state == 200) {
        isvalidate(true);
        print("중복이야");
      } else {
        isvalidate(false);
      }
    } catch (e) {
      Get.snackbar("오류발생", "$e");
    }
  }

  String? onCheckbox(bool check) {
    if (check == false) {
      return "기기정보 약관 동의 해주세요";
    }
    return null;
  }

  void checkRegister() {
    final isValid = registerFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    registerFormKey.currentState!.save();
  }

  changeCheck(checked) {
    ischecked(checked);
  }

  test() {
    change = !change;
    isAgree(change);
    print(isAgree);
  }

  savedUserInfo(
      var accessToken, var refreshToken, var nickname, var userDevice) {
    storage.write(key: "accessToken", value: "Bearer $accessToken");
    storage.write(key: "refreshToken", value: "Bearer $refreshToken");
    storage.write(key: "nickname", value: nickname);
    storage.write(key: "userDevice", value: userDevice);
  }

  register() async {
    //조건을 먼저 확인을 한 뒤 실행해야됨 (무조건임 )
    await initPlatform();
    //기기의 고유 식별값

    _andriodUniqueId = _deviceData["androidId"];
    // //닉네임 설정
    _user.userNickname = nickName.value;
    // //비밀번호 설정
    _user.userDevice = _andriodUniqueId;
    try {
      if (nickName.value.isEmpty) {
        Get.snackbar("오류", "닉네임을 입력해주세요");
      } else {
        if (isvalidate.value == true) {
          Get.snackbar("오류", "중복된 닉네임입니다.");
        } else if (ischecked.isFalse) {
          Get.snackbar("오류", "기기고유정보 사용에 동의해주세요");
        } else {
          print("유저 정보 $_user");
          var dio = await AuthServices().authDio();
          final response = await dio.post('/user/sign-up', data: {
            "userNickname": nickName.value,
            "userDevice": _andriodUniqueId
          });
          final accessToken = response.data["data"]["accessToken"];
          final refreshToken = response.data["data"]["refreshToken"];
          final nickname = nickName.value;
          final userDevice = _andriodUniqueId;

          savedUserInfo(accessToken, refreshToken, nickname, userDevice);

          Get.offNamed("/dashboard");
          Get.snackbar("회원가입 성공", "회원이 되신 것을 축하드립니다.");
        }
      }
    } on DioError catch (e) {
      logger.e(e.response?.statusCode);
      logger.e(e.response?.data);
      logger.e(e.message);
    }
  }
}
