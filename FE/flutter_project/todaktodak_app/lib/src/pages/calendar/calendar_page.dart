import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/components/calender/MyCalender.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/calendar/calendar_controller.dart';

import '../../controller/dashboard/dashboard_controller.dart';

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

class CalendarPage extends StatelessWidget {
  final controller = Get.put(CalendarController(), permanent: true);

  CalendarPage({super.key});

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
            Get.toNamed('/write');
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Palette.greyColor,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '토닥토닥',
          style: TextStyle(
            color: Palette.blackTextColor,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const MyCalendar(),
          Expanded(
            child: Stack(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 16),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Column(
                //             children: [
                //               Image.asset(
                //                 'assets/images/happy.png',
                //                 width: 40,
                //               ),
                //               const Text('행복'),
                //               Text('7일'),
                //             ],
                //           ),
                //           SizedBox(
                //             width: 20,
                //           ),
                //           Column(
                //             children: [
                //               Image.asset(
                //                 'assets/images/sad.png',
                //                 width: 40,
                //               ),
                //               const Text('슬픔'),
                //               Text('3일'),
                //             ],
                //           ),
                //           SizedBox(
                //             width: 20,
                //           ),
                //           Column(
                //             children: [
                //               Image.asset(
                //                 'assets/images/angry.png',
                //                 width: 40,
                //               ),
                //               const Text('화남'),
                //               Text('2일'),
                //             ],
                //           ),
                //         ],
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //     ],
                //   ),
                // ),
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

//그냥 테스트
// class CalendarPage extends StatelessWidget {
//   const CalendarPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
