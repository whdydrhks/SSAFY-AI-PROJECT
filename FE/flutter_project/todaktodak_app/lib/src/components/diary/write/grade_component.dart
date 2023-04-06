import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';
import 'package:test_app/src/controller/diary/diary_write_controller.dart';

class GradeComponent extends StatelessWidget {
  GradeComponent({super.key});
  final controller = Get.put(DiaryWriteController());
  final gradeList = [
    "assets/images/1.png",
    "assets/images/2.png",
    "assets/images/3.png",
    "assets/images/4.png",
    "assets/images/5.png",
  ];

  _box(ThemeMode currentMode) {
    return BoxDecoration(
        color: Mode.boxMode(currentMode),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 0.5,
            color: Mode.shadowMode(currentMode),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.8,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: _box(currentMode),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "평점",
                      style: TextStyle(
                          fontSize: 24,
                          color: Mode.textMode(currentMode),
                          fontFamily: 'Jua_Regular'),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 8,
                    margin:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        5,
                        (i) => Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 6.4,
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  final selectedGrade = i + 1;
                                  Get.find<DiaryWriteController>()
                                      .ChangeGradePoint(selectedGrade);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 2),
                                    child: Obx(() => ClipRect(
                                            child: ColorFiltered(
                                          colorFilter:
                                              Get.find<DiaryWriteController>()
                                                          .diaryScore
                                                          .value ==
                                                      i + 1
                                                  ? const ColorFilter.mode(
                                                      Colors.transparent,
                                                      BlendMode.colorBurn,
                                                    )
                                                  : ColorFilter.mode(
                                                      Mode.boxMode(currentMode),
                                                      BlendMode.saturation),
                                          child: Image.asset(
                                            gradeList[i],
                                            width: 48,
                                            height: 80,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        )))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}
