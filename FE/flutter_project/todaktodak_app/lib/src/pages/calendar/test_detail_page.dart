import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/calendar/calendar_controller.dart';

class TestDetailPage extends StatelessWidget {
  TestDetailPage({Key? key}) : super(key: key);

  final CalendarController _calendarController = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Detail Page'),
      ),
      body: Obx(
        () => Center(
          child: Column(
            children: [
              Text('${_calendarController.selectedDay}'),
              Text('${Get.parameters['id']}'),
            ],
          ),
        ),
      ),
    );
  }
}
