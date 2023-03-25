import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/model/diary/get_diary_list_result.dart';

import '../../../controller/diary/diary_controller.dart';

class DiaryListComponent extends StatefulWidget {
  DiaryListComponent({super.key, required List diaryList});

  @override
  State<DiaryListComponent> createState() => _DiaryListComponentState();
}

class _DiaryListComponentState extends State<DiaryListComponent> {
  _box() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 0.5,
            color: Color(0x35531F13),
          )
        ]);
  }

  String _weekToKorean(var week) {
    switch (week) {
      case 'MONDAY':
        return '월요일';
      case 'TUESDAY':
        return '화요일';
      case 'WEDNESDAY':
        return '수요일';
      case 'THURSDAY':
        return '목요일';
      case 'FRIDAY':
        return '금요일';
      case 'SATURDAY':
        return '토요일';
      case 'SUNDAY':
        return '일요일';
    }
    return '';
  }

  @override
  void initState() {
    DiaryController.to.diaryListModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final diaryList = DiaryController.to.diaryListModel;
    final gradeList = DiaryController.to.gradeList;

    return Obx(() => ListView(
          children: [
            for (int i = 0; i < diaryList.length; i++) ...[
              InkWell(
                onTap: () {
                  print(diaryList[i].diaryId);
                  Get.toNamed("/detail/${diaryList[i].diaryId}",
                      arguments:
                          "${(diaryList[i].diaryCreatedDate.toString()).substring(0, 10)} ${_weekToKorean(diaryList[i].diaryCreatedDayOfWeek)}");
                },
                child: Container(
                    width: 320,
                    height: 240,
                    decoration: _box(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          gradeList[(diaryList[i].diaryScore as int) - 1],
                          width: 72,
                          height: 120,
                        ),
                        Text(
                          "${(diaryList[i].diaryCreatedDate.toString()).substring(0, 10)} ${_weekToKorean(diaryList[i].diaryCreatedDayOfWeek)}",
                          style: TextStyle(fontSize: 24),
                        )
                      ],
                    )),
              ),
              const SizedBox(
                height: 24,
              )
            ]
          ],
        ));
  }
}
