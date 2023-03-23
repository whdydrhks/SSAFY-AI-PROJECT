import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/services/auth/get_services.dart';

class DashBoardController extends GetxController {
  final storage = const FlutterSecureStorage();
  final userId = "";
  var myId = "".obs;

  var tabIndex = 0;

  @override
  onInit() async {
    // storage.deleteAll();

    final userId = await storage.read(key: "userId");
    Future.delayed(const Duration(seconds: 2));
    print(userId);
    if (userId == null) {
      Future.delayed(const Duration(seconds: 2));
      Map<String, String> allValues = await storage.readAll();
      allValues.forEach((key, value) {
        print('$key $value');
      });
      allValues.forEach((key, value) async {
        if (key == 'userInfo') {
          await getUserId(value);
        }
      });
    }
    final getId = await storage.read(key: "userId");
    Future.delayed(const Duration(seconds: 2));
    get1(getId!);
    super.onInit();
  }

  get1(String id) {
    myId(id);
  }

  getUserId(String nickname) async {
    try {
      print('nickname 받았어 $nickname');
      var data = await GetSerivces().getUserId(nickname);
      print(data);
      if (data.state == 200) {
        storage.write(key: "userId", value: data.data!.userId.toString());
      }
    } catch (e) {
      print("에러 발생 $e");
    }
  }

  void changeTabIndex(int index) {
    tabIndex = index;
    print(tabIndex);
    update();
  }
}
