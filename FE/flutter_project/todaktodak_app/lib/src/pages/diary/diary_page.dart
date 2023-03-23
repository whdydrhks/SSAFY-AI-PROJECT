import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/components/diary/list/diary_list_card.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/calendar/calendar_controller.dart';
import 'package:test_app/src/controller/diary/diary_controller.dart';

class DiaryPage extends StatelessWidget {
  final _controller = Get.put(DiaryController());

  DiaryPage({super.key});

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
            for (var diary in _controller.iterateDiaryList())
              DiaryListCard(diary: diary),
          ],
        ),
      ),
    );
  }
}
