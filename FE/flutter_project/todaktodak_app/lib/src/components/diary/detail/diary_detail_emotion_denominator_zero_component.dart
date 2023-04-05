import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';

import '../../../controller/diary/diary_datail_controller.dart';

class DiaryDetailEmotionDenominatorZeroComponent extends StatelessWidget {
  const DiaryDetailEmotionDenominatorZeroComponent({super.key, Key? key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DiaryDetailController());
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Text("AI 감정 분석",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Jua_Regular',
                        color: Mode.textMode(currentMode))),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: List.generate(
                          5,
                          (i) => Row(
                                children: [
                                  Image.asset(
                                    controller.images[i].imagePath!,
                                    width: 40,
                                    height: 80,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  const Expanded(
                                      child: SizedBox(
                                    height: 8,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      child: LinearProgressIndicator(
                                        value: 0,
                                        backgroundColor: Color(0xffD6D6D6),
                                      ),
                                    ),
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 9,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "0",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Jua_Regular',
                                            color: Mode.textMode(currentMode)),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                    ))
              ],
            ),
          );
        });
  }
}
