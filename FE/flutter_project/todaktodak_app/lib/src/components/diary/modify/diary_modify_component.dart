import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';
import 'package:test_app/src/controller/diary/diary_modify_controller.dart';

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
    final controller = Get.put(ModifyController());
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
                controller: controller.textController,
                onChanged: (value) {
                  controller.changeDiaryText(value);
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "일기를 작성해주세요",
                ),
                style: TextStyle(
                    fontFamily: 'NEXONLv1GothicRegular',
                    fontWeight: FontWeight.w600,
                    color: Mode.textMode(currentMode)),
                maxLines: 8,
              ),
            ),
          );
        });
  }
}
