import 'package:get/get.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();
  final RxBool ischecked = false.obs;
  final RxBool isAgree = false.obs;
  final RxString nickName = "".obs;

  List<bool> register = [false, false];
  bool change = false;
  changeCheck(checked) {
    ischecked(checked);
  }

  changeNickname(String nick) {
    nickName(nick);
  }

  test() {
    change = !change;
    isAgree(change);
    print(isAgree);
  }

  registerIndex(int index) {
    register[index] = true;
    update();
  }
}
