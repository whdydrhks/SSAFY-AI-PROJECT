import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/components/calender/my_calendar.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/calendar/calendar_controller.dart';

class Event {
  final DateTime date;
  final int rating;
  final int id;

  Event({
    required this.date,
    required this.rating,
    required this.id,
  });
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final controller = Get.put(CalendarController(), permanent: true);

  Widget writeButton() {
    return Padding(
      padding: const EdgeInsets.only(
        right: 16,
        bottom: 16,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Palette.pinkColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onPressed: () {
            var selectedYear = controller.selectedDay.value.year;
            var selectedMonth = controller.selectedDay.value.month;
            var selectedDay = controller.selectedDay.value.day;
            if (controller.events.value[
                    DateTime(selectedYear, selectedMonth, selectedDay)] ==
                null) {
              Get.toNamed('/write', arguments: controller.selectedDay.value);
            } else {
              Get.toNamed(
                  '/detail/${controller.events.value[DateTime(selectedYear, selectedMonth, selectedDay)]![0].id}',
                  arguments: controller
                      .events
                      .value[DateTime(
                          selectedYear, selectedMonth, selectedDay)]![0]
                      .date
                      .toString()
                      .substring(0, 10));
            }
          },
          child: Image.asset(
            'assets/images/write_icon.png',
            width: 27,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchAllDiaryList();
    // print('캘린더 페이지 빌드');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Obx(() => MyCalendar(
                events: controller.events.value,
                changeSelectedDay: controller.changeSelectedDay,
                getEventsFromDay: controller.getEventsFromDay,
                selectedDay: controller.selectedDay.value,
              )),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: writeButton(),
                ),
              ],
            ),
          ),
          // writeButton(),
        ],
      ),
    );
  }
}
