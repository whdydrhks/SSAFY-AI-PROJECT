import 'package:get/get.dart';
import 'package:test_app/src/pages/calendar/calendar_page.dart';

class CalendarController extends GetxController {
  static CalendarController get to => Get.find();

  // 초기 이벤트 데이터를 넣어줄 변수
  Rx<Map<DateTime, List<Event>>> events = Rx<Map<DateTime, List<Event>>>({});

  // 현재 선택한 날짜
  Rx<DateTime> selectedDay = DateTime.now().obs;

  void changeSelectedDay(DateTime day) {
    selectedDay(day);
  }

  void fetchEvents() {
    print('캘린더에서 이벤트를 가져오는 함수 호출');
    // 더미 데이터 추가
    events({
      DateTime(2023, 3, 4): [
        Event(date: DateTime(2023, 3, 4), feel: 'sad'),
      ],
      DateTime(2023, 3, 8): [
        Event(date: DateTime(2023, 3, 8), feel: 'happy'),
      ],
      DateTime(2023, 3, 10): [
        Event(date: DateTime(2023, 3, 8), feel: 'happy'),
      ],
      DateTime(2023, 3, 11): [
        Event(date: DateTime(2023, 3, 8), feel: 'angry'),
      ],
      DateTime(2023, 3, 8): [
        Event(date: DateTime(2023, 3, 8), feel: 'upset'),
      ],
    });
  }

  List<Event> getEventsFromDay(DateTime day) {
    return events.value[day] ?? [];
  }
}
