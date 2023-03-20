import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/calendar/calendar_controller.dart';
import 'package:test_app/src/pages/calendar/calendar_page.dart';

class MyCalender extends StatefulWidget {
  const MyCalender({Key? key}) : super(key: key);

  @override
  State<MyCalender> createState() => _MyCalenderState();
}

class _MyCalenderState extends State<MyCalender> {
  DateTime? selectedDay = DateTime.now();

  // CalendarController 접근 하기
  CalendarController _calendarController = Get.put(CalendarController());

  @override
  void initState() {
    super.initState();
    _calendarController.fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: TableCalendar(
          // 이벤트 추가
          eventLoader: (day) {
            return _calendarController.getEventsFromDay(day);
          },
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              final dateTime = DateTime.parse(day.toString().substring(0, 10));
              final eventList = _calendarController.getEventsFromDay(dateTime);
              if (eventList.isNotEmpty) {
                final feel = eventList.first.feel;
                return Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Image.asset('assets/images/$feel.png'),
                  ),
                );
              }
              return null;
            },
          ),

          focusedDay: DateTime.now(),
          firstDay: DateTime(1800),
          lastDay: DateTime(3000),
          // 오늘 이후 날짜 선택 불가
          enabledDayPredicate: (DateTime date) {
            bool isCanSelect = date.isBefore(DateTime.now());
            return isCanSelect;
          },

          // 캘린더 스타일
          calendarStyle: const CalendarStyle(
            markerSize: 10,
            markerDecoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            outsideDaysVisible: false,
            isTodayHighlighted: false,
            defaultTextStyle: TextStyle(
              color: Palette.blackTextColor,
              fontSize: 16,
            ),
            weekendTextStyle: TextStyle(
              color: Palette.blackTextColor,
              fontSize: 16,
            ),
            defaultDecoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border(
                bottom: BorderSide(
                  color: Palette.pinkColor,
                  width: 1,
                ),
              ),
            ),
            selectedTextStyle: TextStyle(
              color: Palette.pinkColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          // 헤더 스타일
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
            headerPadding: EdgeInsets.only(
              top: 20,
              bottom: 10,
            ),
          ),
          onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
            setState(() {
              this.selectedDay = selectedDay;
            });
            _calendarController.selectedDay = selectedDay as Rx<DateTime>;
          },
          selectedDayPredicate: (DateTime date) {
            if (selectedDay == null) {
              return false;
            }
            return date.year == selectedDay!.year &&
                date.month == selectedDay!.month &&
                date.day == selectedDay!.day;
          },
        ),
      ),
    );
  }
}
