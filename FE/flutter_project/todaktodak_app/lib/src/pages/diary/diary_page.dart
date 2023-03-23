import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/diary/diary_controller.dart';

class DiaryPage extends StatelessWidget {
  final _controller = Get.put(DiaryController());

  DiaryPage({super.key});
  _box() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 0.5,
            color: Color(0x35531F13),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.greyColor,
        elevation: 0,
        title: const Text(
          '일기 목록',
          style: TextStyle(
            color: Palette.blackTextColor,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        child: ListView(
          children: [
            for (int i = 0; i < _controller.diaryListModel.length; i++) ...[
              Container(
                  width: 320,
                  height: 240,
                  decoration: _box(),
                  child: Column(
                    children: [
                      Image.asset(
                        _controller.gradeList[
                            (_controller.diaryListModel[i].diaryScore as int) -
                                1],
                        width: 72,
                        height: 120,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 24,
              )
            ]
          ],
        ),
      ),
    );
  }
}
