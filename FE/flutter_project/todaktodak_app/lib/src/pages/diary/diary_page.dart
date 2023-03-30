import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/diary/diary_controller.dart';

import '../../model/calendar/all_diary_model.dart';

class DiaryPage extends StatefulWidget {
  DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final _controller = Get.put(DiaryController());

  @override
  Widget build(BuildContext context) {
    _controller.fetchDiaryList();
    var _diaryList = _controller.iterateDiaryList();
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
        child: Obx(
          () {
            final diaryList = _controller.diaryList.value;
            return ListView(
              children: [
                for (var diary in diaryList)
                  Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          final diaryId = diary.id;
                          final eventDay =
                              diary.date.toString().substring(0, 10);

                          Get.toNamed('/detail/$diaryId', arguments: eventDay);
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
                              Image.asset(
                                  'assets/images/score/${diary.rating}.png',
                                  width: 60),
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
            );
          },
        ),
      ),
    );
  }
}
