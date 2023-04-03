import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/diary/diary_write_controller.dart';

class DiaryWriteComponent extends StatelessWidget {
  const DiaryWriteComponent({super.key});

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
                decoration: const InputDecoration(
                  hintText: "일기를 작성해주세요",
                ),
                style: TextStyle(
                    fontFamily: 'NEXONLv1GothicRegular',
                    color: Mode.textMode(currentMode)),
                maxLines: 8,
              ),
            ),
          );
        });
  }
}
