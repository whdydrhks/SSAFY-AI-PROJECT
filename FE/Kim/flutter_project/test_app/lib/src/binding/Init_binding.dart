import 'package:get/get.dart';
import 'package:test_app/src/controller/register_controller.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(() => RegisterController());
  }
}
