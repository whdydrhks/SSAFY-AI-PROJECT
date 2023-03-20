import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/components/diary/write/chatbot_component.dart';
import 'package:test_app/src/components/diary/write/diary_write_component.dart';
import 'package:test_app/src/components/diary/write/emotion_component.dart';
import 'package:test_app/src/components/diary/write/people_component.dart';
import 'package:test_app/src/components/diary/write/stt_component.dart';

class DiaryWritePage extends StatelessWidget {
  _sizedBox() {
    return SizedBox(
      height: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(size: 32),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "일기작성",
            style: TextStyle(fontSize: 24, color: Color(0xff212529)),
          ),
          leading: IconButton(
            color: Color(0xff212529),
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.keyboard_arrow_left),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ChatBotComponent(),
                    _sizedBox(),
                    SttComponent(),
                    _sizedBox(),
                    DiaryWriteComponent(),
                    _sizedBox(),
                    EmotionComponent(),
                    _sizedBox(),
                    PeopleComponent(),
                    _sizedBox(),
                  ],
                )),
          ),
        ),
        bottomNavigationBar: Container(
          height: 64,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffF1648A),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
              child: Text(
                "작성하기",
                style: TextStyle(fontSize: 24),
              )),
        ));
  }
}
