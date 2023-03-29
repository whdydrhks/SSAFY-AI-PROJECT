import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/diary/diary_modify_controller.dart';

class ChatBotComponent extends StatelessWidget {
  const ChatBotComponent({super.key});
  _box(ThemeMode currentMode) {
    return BoxDecoration(
        color: currentMode == ThemeMode.dark
            ? Color(0xff292929)
            : Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow:  [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 0.5,
            color: currentMode == ThemeMode.dark ? Color(0xff292929): Color(0x35531F13),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ModifyController());
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return Row(
            children: [
              SizedBox(
                  width: 84,
                  height: 84,
                  child: Image.asset("assets/images/happy.png")),
              const SizedBox(
                width: 8,
              ),
              Container(
                width: 278,
                height: 50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: _box(currentMode),
                child: Text(
                  controller.chatbotMessage.value,
                  style: TextStyle(
                      color: currentMode == ThemeMode.dark
                          ? Colors.white
                          : Palette.blackTextColor),
                ),
              )
            ],
          );
        });
  }
}
