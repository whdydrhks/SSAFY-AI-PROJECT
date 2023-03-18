import 'package:get/get.dart';
import 'package:test_app/src/controller/analysis_controller.dart';
import 'package:test_app/src/controller/calendar_controller.dart';
import 'package:test_app/src/controller/dashboard_controller.dart';
import 'package:test_app/src/controller/diary_controller.dart';
import 'package:test_app/src/controller/register_controller.dart';
import 'package:test_app/src/controller/setting_controller.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(() => RegisterController());
    Get.put(DashBoardController());
    Get.put(CalendarController());
    Get.put(DiaryController());
    Get.put(AnalysisController());
    Get.put(SettingController());
  }
}
