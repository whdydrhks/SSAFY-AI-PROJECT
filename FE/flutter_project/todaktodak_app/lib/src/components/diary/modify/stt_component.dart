import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';
import 'package:test_app/src/controller/diary/diary_write_controller.dart';

class SttComponent extends StatelessWidget {
  SttComponent({super.key});
  _box(ThemeMode currentMode) {
    return BoxDecoration(
        color: Mode.boxMode(currentMode),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow:  [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 0.5,
            color: Mode.shadowMode(currentMode),
          )
        ]);
  }

  final controller = Get.put(DiaryWriteController());
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable:  MyApp.themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return Container(
          width: 360,
          height: 64,
          decoration: _box(currentMode),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      controller.speechText.value,
                      style:  TextStyle(fontSize: 14, fontFamily: 'Jua_Regular', color: Mode.textMode(currentMode)),
                      maxLines: 10,
                    ),
                  )),
              Obx(() => AvatarGlow(
                    animate: controller.isListening.value,
                    glowColor: Colors.blue,
                    endRadius: 35.0,
                    duration: const Duration(milliseconds: 2000),
                    repeat: true,
                    repeatPauseDuration: const Duration(microseconds: 100),
                    child: GestureDetector(
                      onTap: () {
                        controller.listen();
                      },
                      child: Container(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(controller.isListening.value == false
                              ? Icons.mic_none
                              : Icons.mic)),
                    ),
                  ))
            ],
          ),
        );
      }
    );
  }
}
