import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/components/diary/write/chatbot_component.dart';
import 'package:test_app/src/components/diary/write/diary_write_component.dart';
import 'package:test_app/src/components/diary/write/emotion_component.dart';
import 'package:test_app/src/components/diary/write/grade_component.dart';
import 'package:test_app/src/components/diary/write/people_component.dart';
import 'package:test_app/src/components/diary/write/stt_component.dart';
import 'package:test_app/src/controller/diary/diary_write_controller.dart';

class DiaryWritePage extends StatelessWidget {
  const DiaryWritePage({super.key});

  _sizedBox() {
    return const SizedBox(
      height: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(size: 32),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            "일기작성",
            style: TextStyle(fontSize: 24, color: Color(0xff212529)),
          ),
          leading: IconButton(
            color: const Color(0xff212529),
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
                  ],
                )),
          ),
        ),
        bottomNavigationBar: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffF1648A),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Get.find<DiaryWriteController>().diaryWrite();
              },
              child: const Text(
                "작성하기",
                style: TextStyle(fontSize: 24),
              )),
        ));
  }
}
