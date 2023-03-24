import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/diary/diary_modify_controller.dart';

class DiaryModifyPage extends StatelessWidget {
  DiaryModifyPage({super.key});
  final _controller = Get.put(ModifyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("${Get.arguments}"),
    );
  }
}
