import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/diary/diary_datail_controller.dart';

class DiaryDetailPeopleComponent extends StatelessWidget {
  DiaryDetailPeopleComponent({super.key});
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

  final _controller = Get.put(DiaryDetailController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 6,
      decoration: _box(),
      child: Image.asset(
        _controller
            .peopleImages[(_controller.diaryDetailData.value.diaryMet![i]) - 1]
            .imagePath!,
        width: 48,
        height: 64,
      ),
    );
  }
}
