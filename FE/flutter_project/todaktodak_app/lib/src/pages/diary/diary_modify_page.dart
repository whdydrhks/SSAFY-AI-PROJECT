import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/components/diary/modify/diary_modify_button_component.dart';
import 'package:test_app/src/controller/diary/diary_modify_controller.dart';

import '../../components/diary/modify/chatbot_component.dart';
import '../../components/diary/modify/diary_modify_component.dart';
import '../../components/diary/modify/emotion_component.dart';
import '../../components/diary/modify/grade_component.dart';
import '../../components/diary/modify/people_component.dart';
import '../../components/diary/modify/stt_component.dart';

class DiaryModifyPage extends StatelessWidget {
  DiaryModifyPage({super.key});
  final _controller = Get.put(ModifyController());
  _sizedBox() {
    return const SizedBox(
      height: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                Get.arguments.value.diaryCreatedDate
                    .toString()
                    .substring(0, 10),
                style: TextStyle(
                    fontSize: 24,
                    color: currentMode == ThemeMode.dark
                        ? Colors.white
                        : Color(0xff212529)),
              ),
              leading: IconButton(
                color: currentMode == ThemeMode.dark
                    ? Colors.white
                    : Color(0xff212529),
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.keyboard_arrow_left),
              ),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
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
                        const DiaryModifyButtonComponent(),
                        _sizedBox(),
                      ],
                    )),
              ),
            ),
          );
        });
  }
}
