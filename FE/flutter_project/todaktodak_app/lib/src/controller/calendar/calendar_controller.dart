import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:test_app/src/pages/calendar/calendar_page.dart';
import 'package:test_app/src/services/auth_dio.dart';

class CalendarController extends GetxController {
  static CalendarController get to => Get.find();

  //로거
  var logger = Logger();
  var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 1),
  );

  // 초기 이벤트 데이터를 넣어줄 변수
  Rx<Map<DateTime, List<Event>>> events = Rx<Map<DateTime, List<Event>>>({});

  // 현재 선택한 날짜
  Rx<DateTime> selectedDay = DateTime.now().obs;
  RxString userId = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllDiaryList();
  }

  void changeSelectedDay(DateTime day) {
    selectedDay(day);
  }

  Rx<Map<DateTime, List<Event>>> getEvents() {
    return events;
  }

  Future<void> fetchAllDiaryList() async {
    Map<DateTime, List<Event>> allDiaryList = {};
    try {
      // loggerNoStack.i('캘린더 정보를 가져오는 함수 호출');
      var dio = await authDio();
      final response = await dio.get('/diary/calendar');
      final List<dynamic> allDiary = response.data['data'];
      // loggerNoStack.i(response);
      for (var diary in allDiary) {
        DateTime originalDate = DateTime.parse(diary['diaryCreateDate']);
        DateTime newTime =
            DateTime(originalDate.year, originalDate.month, originalDate.day);
        allDiaryList[newTime] = [
          Event(
              date: newTime, rating: diary['diaryScore'], id: diary['diaryId']),
        ];
      }
      events.value = allDiaryList;
    } on DioError catch (e) {
      logger.e(e.response?.statusCode);
      logger.e(e.response?.data);
      logger.e(e.message);
      // add appropriate error handling logic
    }
  }

  List<Event> getEventsFromDay(DateTime day) {
    return events.value[day] ?? [];
  }
}
