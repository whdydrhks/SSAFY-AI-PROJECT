import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/components/calender/MyCalender.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/calendar/calendar_controller.dart';

class Event {
  final DateTime date;
  final String feel;

  Event({required this.date, required this.feel});
}

class CalendarPage extends StatelessWidget {
  final controller = Get.put(CalendarController(), permanent: true);

  CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.greyColor,
          elevation: 0,
          title: Text(
            '달력',
            style: TextStyle(color: Palette.blackTextColor, fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MyCalender(),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: FloatingActionButton(
                    backgroundColor: Palette.pinkColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onPressed: () {
                      Get.toNamed('/write');
                    },
                    child: Image.asset(
                      'assets/images/write_icon.png',
                      width: 27,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
