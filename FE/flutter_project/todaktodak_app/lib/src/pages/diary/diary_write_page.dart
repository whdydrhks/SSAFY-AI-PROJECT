import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/components/diary/write/chatbot_component.dart';
import 'package:test_app/src/components/diary/write/diary_write_button_component.dart';
import 'package:test_app/src/components/diary/write/diary_write_component.dart';
import 'package:test_app/src/components/diary/write/emotion_component.dart';
import 'package:test_app/src/components/diary/write/grade_component.dart';
import 'package:test_app/src/components/diary/write/people_component.dart';
import 'package:test_app/src/components/diary/write/stt_component.dart';
import 'package:test_app/src/components/tutorial/first_tutorial.dart';
import 'package:test_app/src/components/tutorial/test_first_tutorial.dart';
import 'package:test_app/src/config/palette.dart';

import '../../controller/app_controller.dart';

class DiaryWritePage extends StatelessWidget {
  DiaryWritePage({super.key});

  _sizedBox() {
    return const SizedBox(
      height: 16,
    );
  }

  final selectedDate = Get.arguments;

  @override
  Widget build(BuildContext context) {
    String nowToDay = DateTime.now().toString().substring(0, 10);
    String selectedDate =
        Get.arguments.toString().substring(0, 10); // "2023-04-03"

    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(size: 32),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                '$selectedDate',
                style: TextStyle(
                    fontSize: 24,
                    color: currentMode == ThemeMode.dark
                        ? Colors.white
                        : Palette.blackTextColor,
                    fontFamily: 'Jua_Regular'),
              ),
              leading: IconButton(
                color: currentMode == ThemeMode.dark
                    ? Colors.white
                    : const Color(0xff212529),
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.keyboard_arrow_left),
              ),
            ),
            extendBodyBehindAppBar: true,
            body: Stack(
              children: [
                SafeArea(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                const ChatBotComponent(),
                                _sizedBox(),
                                SttComponent(),
                                _sizedBox(),
                                const DiaryWriteComponent(),
                                _sizedBox(),
                                GradeComponent(),
                                _sizedBox(),
                                const EmotionComponent(),
                                _sizedBox(),
                                const PeopleComponent(),
                                _sizedBox(),
                                const DiaryWriteButtonComponent(),
                                _sizedBox(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                FirstTutorial(),
              ],
            ),
          );
        });
  }
}
