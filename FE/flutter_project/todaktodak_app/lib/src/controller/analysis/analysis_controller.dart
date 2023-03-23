import 'package:get/get.dart';

class AnalysisController extends GetxController {
  static AnalysisController get to => Get.find();

  final count = 0.obs;

  void increase() => count.value++;
}
