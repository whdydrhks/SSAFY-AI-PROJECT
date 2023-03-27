import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/diary/diary_datail_controller.dart';

class DiaryDetailDiaryContentsComponent extends StatelessWidget {
  DiaryDetailDiaryContentsComponent({super.key});
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
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 4,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: _box(),
          child: _controller.diaryDetailData.value.diaryContent!.length <= 0
              ? Center(
                  child: Text("일기내용이 비어있습니다.", style: TextStyle(fontSize: 24)),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(
                    "${_controller.diaryDetailData.value.diaryContent}",
                    style: TextStyle(fontSize: 24),
                    maxLines: 10,
                  ),
                ),
        ),
      ),
    );
  }
}
