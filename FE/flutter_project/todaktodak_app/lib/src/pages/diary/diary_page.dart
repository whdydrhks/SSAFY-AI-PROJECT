import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/calendar/calendar_controller.dart';
import 'package:test_app/src/controller/diary/diary_controller.dart';

class DiaryPage extends StatelessWidget {
  final _controller = Get.put(DiaryController());

  DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.greyColor,
        elevation: 0,
        title: const Text(
          '일기 목록',
          style: TextStyle(
            color: Palette.blackTextColor,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        child: ListView(
          children: [
            for (var diary in _controller.iterateDiaryList())
              Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/detail/${diary.id}');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width - 32,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          // Image.asset('assets/images/${diary['feel']}.png',
                          //     width: 60),
                          Text(
                            '${diary.date.substring(0, 10)} ${diary.day}',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
