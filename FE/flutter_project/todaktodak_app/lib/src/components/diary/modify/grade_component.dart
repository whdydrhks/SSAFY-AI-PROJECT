import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';
import 'package:test_app/src/controller/diary/diary_modify_controller.dart';
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

  _box(ThemeMode currentMode) {
    return BoxDecoration(
        color: currentMode == ThemeMode.dark
            ? const Color(0xff292929)
            : Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 0.5,
            color: currentMode == ThemeMode.dark
                ? const Color(0xff292929)
                : const Color(0x35531F13),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return Container(
              width: 360,
              height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: _box(currentMode),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "평점",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Jua_Regular',
                        color: Mode.textMode(currentMode)),
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
                            Get.find<ModifyController>()
                                .testChangeGradePoint(selectedGrade);
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Obx(() => ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      Mode.boxMode(currentMode),
                                      Get.find<ModifyController>().test.value ==
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
        });
  }
}
