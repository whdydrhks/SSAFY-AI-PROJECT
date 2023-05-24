import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/diary/diary_modify_controller.dart';

class SttComponent extends StatelessWidget {
  SttComponent({Key? key}) : super(key: key);

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
                Expanded(
                  child: Obx(
                    () => Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 1.5,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 16, bottom: 8),
                                child: TextFormField(
                                  validator: (text) {
                                    return null;
                                  },
                                  controller: controller.speechController,
                                  onChanged: (text) {
                                    controller.textInput(text);
                                  },
                                  decoration: const InputDecoration(
                                    hintText:
                                        "저에게 메세지를 남기고 싶다면 음성인식을 하거나 입력하여 전송해주세요",
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1,
                                    fontFamily: 'Jua_Regular',
                                    color: Mode.textMode(currentMode),
                                  ),
                                  maxLines: 5,
                                ),
                              ),
                            ),
                          ),
                          AvatarGlow(
                            animate: controller.isListening.value,
                            glowColor: const Color(0xffF1648A),
                            shape: BoxShape.circle,
                            endRadius: 20.0,
                            duration: const Duration(milliseconds: 2000),
                            repeat: true,
                            repeatPauseDuration:
                                const Duration(microseconds: 50),
                            child: GestureDetector(
                              onTap: () {
                                controller.listen();
                              },
                              child: Icon(
                                controller.isListening.value == false
                                    ? Icons.mic_none
                                    : Icons.mic,
                                color: Color(0xffF2A2B8),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.find<ModifyController>().Chatbot(
                                  Get.find<ModifyController>()
                                      .speechText
                                      .value);
                            },
                            child: const Icon(
                              Icons.send,
                              color: Color(0xff83C9E7),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  BoxDecoration _box(ThemeMode currentMode) {
    return BoxDecoration(
      color: Mode.boxMode(currentMode),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 3),
          blurRadius: 0.5,
          color: Mode.shadowMode(currentMode),
        ),
      ],
    );
  }
}
