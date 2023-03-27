import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/diary/diary_datail_controller.dart';

class DiaryDetailEmotionsComponent extends StatelessWidget {
  DiaryDetailEmotionsComponent({super.key});
  final _controller = Get.put(DiaryDetailController());
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
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 6,
        decoration: _box(),
        child: Row(
          children: [
            for (int i = 0;
                i < _controller.diaryDetailData.value.diaryEmotion!.length;
                i++) ...[
              Image.asset(_controller
                  .images[
                      (_controller.diaryDetailData.value.diaryEmotion![i] - 1) -
                          1]
                  .imagePath!)
            ]
          ],
        ));
  }
}
