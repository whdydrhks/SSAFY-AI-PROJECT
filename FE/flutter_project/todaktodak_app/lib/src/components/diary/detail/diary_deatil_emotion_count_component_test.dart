import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../config/mode.dart';
import '../../../controller/diary/diary_datail_controller.dart';
import 'diary_detail_emotion_denominator_component_test.dart';
import 'diary_detail_emotion_denominator_zero_component_test.dart';

class DiaryDetailEmotionCountComponentTest extends StatelessWidget {
  const DiaryDetailEmotionCountComponentTest({super.key});
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
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: _box(currentMode),
              child: controller.emotionSum.value == 0
                  ? const DiaryDetailEmotionDenominatorZeroComponentTest()
                  : const DiaryDetailEmotionDenominatorComponentTest());
        });
  }
}
