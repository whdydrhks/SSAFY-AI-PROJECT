import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/diary/diary_controller.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final DiaryController diaryController = Get.put(DiaryController());

  @override
  void initState() {
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
      body: const Padding(
        padding: EdgeInsets.only(top: 8, bottom: 24),
      ),
    );
  }
}
