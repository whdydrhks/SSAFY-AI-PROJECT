import 'package:get/get.dart';
import 'package:test_app/src/controller/analysis/analysis_controller.dart';
import 'package:test_app/src/controller/app_controller.dart';
import 'package:test_app/src/controller/calendar/calendar_controller.dart';
import 'package:test_app/src/controller/dashboard/dashboard_controller.dart';
import 'package:test_app/src/controller/diary/diary_controller.dart';
import 'package:test_app/src/controller/setting/setting_controller.dart';

import '../controller/auth/register_controller.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(() => RegisterController());
    Get.put(DashBoardController());
    Get.put(CalendarController());
    Get.put(DiaryController());
    Get.put(AnalysisController());
    Get.put(SettingController());
    Get.put(AppController());
  }
}
