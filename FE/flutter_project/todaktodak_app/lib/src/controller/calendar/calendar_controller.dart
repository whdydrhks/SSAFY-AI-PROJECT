import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  final storage = const FlutterSecureStorage();
  @override
  onInit() async {
    // storage.deleteAll();
    Map<String, String> allValues = await storage.readAll();
    allValues.forEach((key, value) {
      print('$key $value');
    });
    super.onInit();
  }

  navigateToDateWrite() {
    Get.toNamed("/write");
  }
}
