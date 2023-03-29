import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  final storage = const FlutterSecureStorage();
  final userId = "";
  var myId = "".obs;

  var tabIndex = 0;

  @override
  onInit() {
    // storage.write(key: 'userId', value: '5');
    // storage.deleteAll();
    test();
    super.onInit();
  }

  test() async {
    Map<String, String> values = await storage.readAll();
    values.forEach((key, value) {});
  }
  // test() async {
  //   final userId = await storage.read(key: "userId");
  //   Future.delayed(const Duration(seconds: 2));
  //   if (userId == null) {
  //     Future.delayed(const Duration(seconds: 2));
  //     Map<String, String> allValues = await storage.readAll();
  //     allValues.forEach((key, value) {
  //       print('$key $value');
  //     });
  //     allValues.forEach((key, value) async {
  //       if (key == 'userInfo') {
  //         getUserId(value);
  //       }
  //     });
  //   }

  //   final getId = await storage.read(key: "userId");
  //   Future.delayed(const Duration(seconds: 2));
  //   get1(getId!);
  // }

  // get1(String id) {
  //   myId(id);
  // }

  // getUserId(String nickname) async {
  //   try {
  //     print('nickname 받았어 $nickname');

  //     var data = await GetSerivces().getUserId(nickname);
  //     print(data);
  //     if (data.state == 200) {
  //       storage.write(key: "userId", value: data.data!.userId.toString());
  //     }
  //   } catch (e) {
  //     print("에러 발생 $e");
  //   }
  // }

  void changeTabIndex(int index) {
    tabIndex = index;
    print(tabIndex);
    update();
  }
}
