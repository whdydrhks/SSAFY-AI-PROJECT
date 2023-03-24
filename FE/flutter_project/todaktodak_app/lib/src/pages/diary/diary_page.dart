import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/components/diary/list/diary_list_component.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/diary/diary_controller.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  @override
  void initState() {
    Get.find<DiaryController>().getDiaryList();
    super.initState();
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
          child: DiaryListComponent()),
    );
  }
}
