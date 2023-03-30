import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';

import '../../../controller/diary/diary_datail_controller.dart';

class DiaryDetailIconComponent extends StatelessWidget {
  const DiaryDetailIconComponent({super.key});
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
    final controller = Get.put(DiaryDetailController());
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  width: 80,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: _box(currentMode),
                  child: Row(
                    children: [
                      Obx(() => Image.asset(
                            controller.gradeList[(controller
                                    .diaryDetailData.value.diaryScore as int) -
                                1],
                            width: 80,
                            height: 160,
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                for (int i = 0;
                                    i <
                                        controller.diaryDetailData.value
                                            .diaryEmotion!.length;
                                    i++) ...[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Obx(() => Image.asset(
                                          controller
                                              .images[(controller
                                                      .diaryDetailData
                                                      .value
                                                      .diaryEmotion![i] -
                                                  1)]
                                              .imagePath!,
                                          width: 40,
                                          height: 80,
                                        )),
                                  )
                                ]
                              ],
                            ),
                            Row(
                              children: [
                                for (int i = 0;
                                    i <
                                        controller.diaryDetailData.value
                                            .diaryMet!.length;
                                    i++) ...[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Obx(() => Image.asset(
                                          controller
                                              .peopleImages[(controller
                                                      .diaryDetailData
                                                      .value
                                                      .diaryMet![i] -
                                                  1)]
                                              .imagePath!,
                                          width: 40,
                                          height: 80,
                                        )),
                                  )
                                ]
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
