import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';
import 'package:test_app/src/controller/diary/diary_datail_controller.dart';

class DiaryDetailAppbar extends StatelessWidget {
  const DiaryDetailAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: MyApp.themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return DropdownButtonHideUnderline(
            child: DropdownButton(
          items: [
            DropdownMenuItem(
              value: 'modify',
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit,
                    color: Color(0xff707070),
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Text(
                    "수정하기",
                    style: TextStyle(color: Color(0xff707070)),
                  )
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'delete',
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete,
                    color: Mode.textMode(currentMode),
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Text("삭제하기", style: TextStyle(color: Color(0xff707070))),
                ],
              ),
            ),
          ],
          onChanged: (value) {
            if (value == 'delete') {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Mode.boxMode(currentMode),
                      content: Text("정말로 삭제하시겠습니까?", style: TextStyle(fontSize:  16, fontFamily: 'Jua_Regular', color: Mode.textMode(currentMode)),),
                      actions: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Get.find<DiaryDetailController>()
                                        .deleteDiary(Get.parameters["diaryId"]);
                                  },
                                  child: Text("예", style: TextStyle(fontSize: 12, fontFamily: 'Jua_Regular', color:  Colors.blue),)),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "아니오",
                                    style: TextStyle(fontSize: 12, fontFamily: 'Jua_Regular', color: Colors.red),
                                  )),
                            ],
                          ),
                        )
                      ],
                    );
                  });
            } else if (value == 'modify') {
              Get.toNamed("/modify/${Get.parameters["diaryId"]}",
                  arguments: Get.find<DiaryDetailController>().diaryDetailData);
            }
          },
          icon: const Icon(Icons.more_horiz_outlined),
        ));
      }
    );
  }
}
