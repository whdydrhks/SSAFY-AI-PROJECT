import 'package:get/get.dart';

class LoadController extends GetxController {
  static LoadController get to => Get.find();
  final RxBool ischecked = false.obs;
  final RxBool isAgree = false.obs;
  final RxString nickName = "".obs;

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
}
