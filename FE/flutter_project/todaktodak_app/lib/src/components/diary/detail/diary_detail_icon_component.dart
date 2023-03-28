import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/diary/diary_datail_controller.dart';

class DiaryDetailIconComponent extends StatelessWidget {
  const DiaryDetailIconComponent({super.key});
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
    final controller = Get.put(DiaryDetailController());
    return Row(
      children: [
        Expanded(
          child: Container(
            width: 80,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            height: MediaQuery.of(context).size.height / 4,
            decoration: _box(),
            child: Row(
              children: [
                Image.asset(
                  controller.gradeList[
                      (controller.diaryDetailData.value.diaryScore as int) - 1],
                  width: 80,
                  height: 160,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          for (int i = 0;
                              i <
                                  controller.diaryDetailData.value.diaryEmotion!
                                      .length;
                              i++) ...[
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Image.asset(
                                controller
                                    .images[(controller.diaryDetailData.value
                                            .diaryEmotion![i] -
                                        1)]
                                    .imagePath!,
                                width: 40,
                                height: 80,
                              ),
                            )
                          ]
                        ],
                      ),
                      Row(
                        children: [
                          for (int i = 0;
                              i <
                                  controller
                                      .diaryDetailData.value.diaryMet!.length;
                              i++) ...[
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Image.asset(
                                controller
                                    .peopleImages[(controller.diaryDetailData
                                            .value.diaryMet![i] -
                                        1)]
                                    .imagePath!,
                                width: 40,
                                height: 80,
                              ),
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
  }
}
