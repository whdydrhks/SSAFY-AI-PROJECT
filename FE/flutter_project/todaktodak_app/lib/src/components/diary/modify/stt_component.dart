import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';
import 'package:test_app/src/controller/diary/diary_modify_controller.dart';

class SttComponent extends StatelessWidget {
  SttComponent({Key? key}) : super(key: key);

  final controller = Get.put(ModifyController());

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 12,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: _box(currentMode),
                        child: TextFormField(
                          controller: controller.speechController,
                          onChanged: (text) {
                            controller.textInput(text);
                          },
                          onSaved: (text) {
                            controller.textInput(text!);
                          },
                          validator: (text) {
                            if (text == null) {
                              return "메세지를 입력해주세요";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              suffixIconConstraints: BoxConstraints(
                                minHeight: 24,
                                minWidth: 24,
                              ),
                              hintText:
                                  "저에게 메세지를 남기고 싶다면 음성인식을 하거나 입력하여 전송해주세요",
                              hintStyle: TextStyle(height: 1.2)),
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Jua_Regular',
                            color: Mode.textMode(currentMode),
                          ),
                          maxLines: 2,
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
                    repeatPauseDuration: const Duration(microseconds: 50),
                    child: GestureDetector(
                        onTap: () {
                          controller.listen();
                          controller.speechController.clear();
                        },
                        child: Icon(
                            controller.isListening.value == false
                                ? Icons.mic_none
                                : Icons.mic,
                            // color: Palette.pinkColor,
                            // color: const Color(0xffF5C6EC),
                            color: const Color(0xffF2A2B8))),
                  ),
                  InkWell(
                    onTap: () {
                      controller.Chatbot(controller.speechText.value);
                    },
                    child: const Icon(Icons.send,
                        // color: Palette.pinkColor,
                        color: Color(0xff00aaff)),
                  ),
                  const SizedBox(
                    width: 16,
                  )
                ],
              ),
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
