import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/diary/diary_datail_controller.dart';

class DiaryDetailGradeComponent extends StatelessWidget {
  const DiaryDetailGradeComponent({super.key});
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
    final controller = Get.put(DiaryDetailController());
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 6,
      decoration: _box(),
      child: Image.asset(
        controller.gradeList[
            (controller.diaryDetailData.value.diaryScore as int) - 1],
        width: 48,
        height: 64,
      ),
    );
  }
}
