import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/diary/diary_modify_controller.dart';

class DiaryModifyButtonComponent extends StatelessWidget {
  const DiaryModifyButtonComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 8,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffF1648A),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            Get.find<ModifyController>().diaryModify();
          },
          child: const Text(
            "작성하기",
            style: TextStyle(
                fontSize: 24, fontFamily: 'Jua_Regular', color: Colors.white),
          )),
    );
  }
}
