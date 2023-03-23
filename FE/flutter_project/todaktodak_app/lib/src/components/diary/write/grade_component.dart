import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/diary/diary_write_controller.dart';

class GradeComponent extends StatelessWidget {
  GradeComponent({super.key});
  final controller = Get.put(DiaryWriteController());
  final gradeList = [
    "assets/images/score1.png",
    "assets/images/score2.png",
    "assets/images/score3.png",
    "assets/images/score4.png",
    "assets/images/score5.png",
  ];

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

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 360,
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: _box(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "평점",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 64,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: gradeList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      final selectedGrade = index + 1;
                      Get.find<DiaryWriteController>()
                          .testChangeGradePoint(selectedGrade);
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Obx(() => ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                Colors.white,
                                Get.find<DiaryWriteController>().test.value ==
                                        index + 1
                                    ? BlendMode.colorBurn
                                    : BlendMode.saturation),
                            child: Image.asset(
                              gradeList[index],
                            )))),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
