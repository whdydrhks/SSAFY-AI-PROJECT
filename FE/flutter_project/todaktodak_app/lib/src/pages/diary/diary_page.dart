import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/diary/diary_controller.dart';

class DiaryPage extends StatelessWidget {
  final controller = Get.put(DiaryController());
  DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("다이어리리스트"),
      ),
    );
  }
}
