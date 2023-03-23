import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/diary/diary_controller.dart';

class DiaryListComponent extends StatelessWidget {
  DiaryListComponent({super.key});
  final _controller = Get.put(DiaryController());
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
  Widget build(BuildContext context) {
    return Obx(() => ListView(
          children: [
            for (int i = 0; i < _controller.diaryListModel.length; i++) ...[
              InkWell(
                onTap: () {
                  print(_controller.diaryListModel[i].diaryId);
                  Get.toNamed(
                      "/detail/${_controller.diaryListModel[i].diaryId}",
                      arguments:
                          "${(_controller.diaryListModel[i].diaryCreatedDate.toString()).substring(0, 10)} ${_weekToKorean(_controller.diaryListModel[i].diaryCreatedDayOfWeek)}");
                },
                child: Container(
                    width: 320,
                    height: 240,
                    decoration: _box(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          _controller.gradeList[(_controller
                                  .diaryListModel[i].diaryScore as int) -
                              1],
                          width: 72,
                          height: 120,
                        ),
                        Text(
                          "${(_controller.diaryListModel[i].diaryCreatedDate.toString()).substring(0, 10)} ${_weekToKorean(_controller.diaryListModel[i].diaryCreatedDayOfWeek)}",
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
