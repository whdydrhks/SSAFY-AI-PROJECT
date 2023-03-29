import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/diary/diary_modify_controller.dart';
import 'package:test_app/src/controller/diary/diary_write_controller.dart';

class DiaryWriteComponent extends StatelessWidget {
  const DiaryWriteComponent({super.key});
  _box(ThemeMode currentMode) {
    return BoxDecoration(
        color: currentMode == ThemeMode.dark ? Color(0xff292929): Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow:  [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 0.5,
            color:  currentMode == ThemeMode.dark ? Color(0xff292929): Color(0x35531F13),
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
            height: 176,
            decoration: _box(currentMode),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              height: 180,
              child: TextField(
                controller: Get.find<ModifyController>().diaryContentController,
                
                onChanged: (value) {
                  Get.find<ModifyController>().changeDiaryText(value);
                },
                decoration: const InputDecoration(
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1.0))),
                maxLines: 8,
              ),
            ),
          );
        });
  }
}
