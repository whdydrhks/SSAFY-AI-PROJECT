import 'dart:convert';

import 'package:get/get.dart';
import 'package:test_app/src/model/calendar/all_diary_model.dart';
import 'package:test_app/src/pages/calendar/calendar_page.dart';
import 'package:http/http.dart' as http;

const BASE_URL = 'http://3.36.114.174:8080/api/v1';

class CalendarController extends GetxController {
  static CalendarController get to => Get.find();

  // 초기 이벤트 데이터를 넣어줄 변수
  Rx<Map<DateTime, List<Event>>> events = Rx<Map<DateTime, List<Event>>>({});

  // 현재 선택한 날짜
  Rx<DateTime> selectedDay = DateTime.now().obs;

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

  fetchAllDiaryList() async {
    print('캘린더에서 이벤트를 가져오는 함수 호출');
    Map<DateTime, List<Event>> allDiaryList = {};
    final url = Uri.parse('$BASE_URL/diary/calendar/1');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print('캘린더에서 이벤트를 가져오는 함수 호출 성공');
      final parsed = jsonDecode(utf8.decode(response.bodyBytes));
      final List<dynamic> allDiary = parsed['data'];
      // print(allDiary);
      for (var diary in allDiary) {
        DateTime originalDate = DateTime.parse(diary['diaryCreateDate']);
        DateTime newTime =
            DateTime(originalDate.year, originalDate.month, originalDate.day);
        allDiaryList[newTime] = [
          Event(
              date: newTime, rating: diary['diaryScore'], id: diary['diaryId']),
        ];
      }
      events(allDiaryList);
    } else {
      // throw Error();
      print('캘린더에서 이벤트를 가져오는 함수 호출 실패');
    }
  }

  List<Event> getEventsFromDay(DateTime day) {
    return events.value[day] ?? [];
  }
}
