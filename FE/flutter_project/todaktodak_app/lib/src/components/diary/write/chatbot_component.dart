import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/diary/diary_write_controller.dart';

class ChatBotComponent extends StatelessWidget {
  const ChatBotComponent({super.key});

  _box(ThemeMode currentMode) {
    return BoxDecoration(
        color: Mode.boxMode(currentMode),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 0.2,
            color: Mode.shadowMode(currentMode),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DiaryWriteController());
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return Obx(() => Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 6,
                      height: MediaQuery.of(context).size.height / 10,
                      child: Image.asset("assets/images/happy.png")),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 300,
                    height: 60,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: _box(currentMode),
                    child: SingleChildScrollView(
                      child: Text(
                        controller.chatbotMessage.value,
                        style: TextStyle(
                            fontFamily: 'Jua_Regular',
                            color: Mode.textMode(currentMode)),
                      ),
                    ),
                  )
                ],
              ));
        });
  }
}
