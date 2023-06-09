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
                      color: Mode.textMode(currentMode),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Text(
                      "수정하기",
                      style: TextStyle(
                          fontFamily: 'Jua_Regular',
                          color: Mode.textMode(currentMode)),
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
                    const SizedBox(
                      width: 18,
                    ),
                    Text("삭제하기",
                        style: TextStyle(
                            fontFamily: 'Jua_Regular',
                            color: Mode.textMode(currentMode))),
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
                        content: Text(
                          "정말로 삭제하시겠습니까?",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Jua_Regular',
                              color: Mode.textMode(currentMode)),
                        ),
                        actions: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Get.find<DiaryDetailController>()
                                          .deleteDiary(
                                              Get.parameters["diaryId"]);
                                    },
                                    child: const Text(
                                      "예",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Jua_Regular',
                                          color: Colors.blue),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "아니오",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Jua_Regular',
                                          color: Colors.red),
                                    )),
                              ],
                            ),
                          )
                        ],
                      );
                    });
              } else if (value == 'modify') {
                Get.offNamed("/modify/${Get.parameters["diaryId"]}",
                    arguments:
                        Get.find<DiaryDetailController>().diaryDetailData);
              }
            },
            icon: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.more_horiz_outlined,
                color: Mode.textMode(currentMode),
              ),
            ),
          ));
        });
  }
}
