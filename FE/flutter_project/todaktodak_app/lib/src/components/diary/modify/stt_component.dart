import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';
import 'package:test_app/src/controller/diary/diary_modify_controller.dart';

class SttComponent extends StatelessWidget {
  SttComponent({super.key});
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

  final controller = Get.put(ModifyController());
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 12,
            decoration: _box(currentMode),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          controller.speechText.value,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Jua_Regular',
                              color: Mode.textMode(currentMode)),
                          maxLines: 10,
                        ),
                      ),
                    )),
                Obx(() => AvatarGlow(
                      animate: controller.isListening.value,
                      glowColor: const Color(0xffF1648A),
                      endRadius: 45.0,
                      duration: const Duration(milliseconds: 2000),
                      repeat: true,
                      repeatPauseDuration: const Duration(microseconds: 100),
                      child: GestureDetector(
                        onTap: () {
                          controller.listen();
                        },
                        child: Container(
                            child: Icon(
                          controller.isListening.value == false
                              ? Icons.mic_none
                              : Icons.mic,
                          color: Mode.textMode(currentMode),
                        )),
                      ),
                    ))
              ],
            ),
          );
        });
  }
}
