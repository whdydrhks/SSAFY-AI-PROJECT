import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/components/analysis/feel_relation_bar_chart.dart';
import 'package:test_app/src/services/auth/auth_services.dart';

class LoadController extends GetxController {
  static LoadController get to => Get.find();
  final storage = const FlutterSecureStorage();

  final RxBool ischecked = false.obs;
  final RxBool isAgree = false.obs;
  final RxString nickName = "".obs;
  final RxString password = "".obs;
  bool change = false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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

  loadup() async {
    try {
      var dio = await AuthServices().authDio();
      final reponse = await dio.post('/user/login',
          data: {"userNickname": nickName.value, "userDevice": password.value});
    } on DioError catch (e) {
      logger.e(e.response?.statusCode);
      logger.e(e.response?.data);
      logger.e(e.message);
    }
    // try {
    //   LoadUser user =
    //       LoadUser(userNickname: nickName.value, userDevice: password.value);
    //   print(user.toString());
    //   print(storage.read(key: 'pass'));
    //   var data = await LoadServices().postLoadUser(user);
    //   if (data == true) {
    //     print("회원가입 성공");
    //     print(storage.readAll().toString());
    //   } else {
    //     print("존재하지 않는 계정입니다.");
    //   }
    // } catch (e) {
    //   Get.snackbar("오류발생", "$e");
    // }
  }
}
