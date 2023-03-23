import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/model/auth/register_user.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  late TextEditingController nicknameController;
  final RxBool ischecked = false.obs;
  final RxBool isAgree = false.obs;
  final RxString nickName = "".obs;
  final RxBool isClicked = false.obs;
  String _andriodUniqueId = "";
  final RegisterUser _user = RegisterUser();
  static final storage = const FlutterSecureStorage();
  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  bool change = false;
  @override
  void onInit() {
    // TODO: implement onInit
    nicknameController = TextEditingController();
    debounce(nickName, (_) {
      print("$_ 변경되었습니다.");
      //여기서 닉네임 중복체크 일어나게 하면된다.
      validateNicknameCheck(_);
    });
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
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  onChangeNickname(String value) {
    nickName(value);
  }

  String? onNicknameLength(String nick) {
    if (nick.isEmpty) {
      return "닉네임을 입력해주세요";
    }
    return null;
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

  register() {
    //조건을 먼저 확인을 한 뒤 실행해야됨 (무조건임 )
    initPlatform();
    //기기의 고유 식별값
    _andriodUniqueId = _deviceData["androidId"];
    // //닉네임 설정
    _user.nickname = nickName.value;
    // //비밀번호 설정
    _user.password = _andriodUniqueId;

    // print(_andriodUniqueId);
    print(_user.toString());

    //user의 정보를 담아서 회원가입 api 통신을 해준다.

    //user의 정보를 storage에 저장해보자.

    storage.write(key: "id", value: _user.nickname);
    storage.write(key: "pass", value: _user.password);
  }
}
