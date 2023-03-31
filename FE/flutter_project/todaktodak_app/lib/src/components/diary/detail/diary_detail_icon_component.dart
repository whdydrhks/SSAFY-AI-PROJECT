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

  String getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return "월요일";
      case 2:
        return "화요일";
      case 3:
        return "수요일";
      case 4:
        return "목요일";
      case 5:
        return "금요일";
      case 6:
        return "토요일";
      case 7:
        return "일요일";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DiaryDetailController());
    final year = int.parse(Get.arguments.toString().substring(0, 4));
    final month = int.parse(Get.arguments.toString().substring(6, 7));
    final day = int.parse(Get.arguments.toString().substring(8, 10));

    DateTime date = DateTime(year, month, day);
    String weekday = getWeekday(date.weekday);
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  width: 80,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: _box(currentMode),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Obx(() => Column(
                                children: [
                                  Image.asset(
                                    controller.gradeList[(controller
                                            .diaryDetailData
                                            .value
                                            .diaryScore as int) -
                                        1],
                                    width: 80,
                                    height: 96,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: 64,
                                    height: 32,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(2, 3),
                                            blurRadius: 0.5,
                                            color: Mode.shadowMode(currentMode),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        weekday,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w100),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 4.8,
                            child: const VerticalDivider(
                                thickness: 1, color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 2.8,
                                    ),
                                    for (int i = 0;
                                        i <
                                            controller.diaryDetailData.value
                                                .diaryEmotion!.length;
                                        i++) ...[
                                      Container(
                                        child: Obx(() => Image.asset(
                                              controller
                                                  .images[(controller
                                                          .diaryDetailData
                                                          .value
                                                          .diaryEmotion![i] -
                                                      1)]
                                                  .imagePath!,
                                              width: 48,
                                              height: 48,
                                            )),
                                      )
                                    ]
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    for (int i = 0;
                                        i <
                                            controller.diaryDetailData.value
                                                .diaryMet!.length;
                                        i++) ...[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 3.6),
                                        child: Obx(() => Image.asset(
                                              controller
                                                  .peopleImages[(controller
                                                          .diaryDetailData
                                                          .value
                                                          .diaryMet![i] -
                                                      1)]
                                                  .imagePath!,
                                              width: 40,
                                              height: 40,
                                            )),
                                      )
                                    ]
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "일기내용",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              "${controller.diaryDetailData.value.diaryContent}",
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              maxLines: 10,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
