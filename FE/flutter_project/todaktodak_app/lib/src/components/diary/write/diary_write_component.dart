import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/diary/diary_write_controller.dart';

class DiaryWriteComponent extends StatelessWidget {
  const DiaryWriteComponent({super.key});
  _box(ThemeMode currentMode) {
    return BoxDecoration(
        color: currentMode == ThemeMode.dark
            ? Palette.blackTextColor
            : Colors.white,
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
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 176,
            decoration: _box(currentMode),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              height: 180,
              child: TextField(
                controller: Get.find<DiaryWriteController>().textController,
                onChanged: (value) {
                  Get.find<DiaryWriteController>().changeDiaryText(value);
                },
                style: TextStyle(
                    fontFamily: 'Jua_Regular',
                    color: currentMode == ThemeMode.dark
                        ? Colors.white
                        : Palette.blackTextColor),
                maxLines: 8,
              ),
            ),
          );
        });
  }
}
