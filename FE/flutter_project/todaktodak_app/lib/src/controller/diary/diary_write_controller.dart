import 'package:get/get.dart';
import 'package:test_app/src/controller/calendar/calendar_controller.dart';

class DiaryWriteController extends GetxController {
  late CalendarController calendar;

  @override
  void dispose() {
    calendar.dispose();
    super.dispose();
  }
}
