import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/components/diary/detail/diray_detail_appbar.dart';

class DiaryDetailPage extends StatelessWidget {
  DiaryDetailPage({super.key});
  final String date = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(date),
        centerTitle: true,
        backgroundColor: Color(0xffF1648A),
        actions: [DiaryDetailAppbar()],
      ),
      
    );
  }
}
