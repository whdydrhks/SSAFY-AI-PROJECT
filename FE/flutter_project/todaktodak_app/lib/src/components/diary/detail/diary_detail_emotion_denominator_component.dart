import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/diary/diary_datail_controller.dart';

class DiaryDetailEmotionDenominatorComponent extends StatelessWidget {
  const DiaryDetailEmotionDenominatorComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DiaryDetailController());
    List<dynamic> colorList = [
      Colors.pink,
      Colors.yellow,
      Colors.blue,
      Colors.orange,
      Colors.green
    ];
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          Text(
            "AI 감정 분석",
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 8,
          ),
          for (int i = 0; i < 5; i++) ...[
            Row(
              children: [
                Image.asset(
                  controller.images[i].imagePath!,
                  width: 40,
                  height: 80,
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: 240,
                  height: 20,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                          value: controller.diaryDetailData.value
                                  .diaryDetailLineEmotionCount![i] /
                              controller.emotionSum.value,
                          color: colorList[i],
                          backgroundColor: const Color(0xffD6D6D6))),
                ),
                SizedBox(
                  width: 10,
                ),
                Center(
                  child: Text(
                    "${(controller.diaryDetailData.value.diaryDetailLineEmotionCount![i] / controller.emotionSum.value * 100).round()}%",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ]
        ],
      ),
    );
  }
}
