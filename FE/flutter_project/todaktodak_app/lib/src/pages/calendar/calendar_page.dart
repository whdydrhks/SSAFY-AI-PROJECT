import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/calendar/calendar_controller.dart';

class CalendarPage extends StatelessWidget {
  final controller = Get.put(CalendarController());

  CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            FloatingActionButton(
              onPressed: () {
                controller.navigateToDateWrite();
              },
            )
          ],
        ));
  }
}
