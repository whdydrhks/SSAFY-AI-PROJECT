import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/controller/diary/diary_datail_controller.dart';

import '../../../config/mode.dart';

class DiaryDetailEmotionCountComponent extends StatelessWidget {
  const DiaryDetailEmotionCountComponent({super.key});
  _box(ThemeMode currentMode) {
    return BoxDecoration(
        color: Mode.boxMode(currentMode),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 0.5,
            color: Mode.shadowMode(currentMode),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DiaryDetailController());
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return Container(
              width: MediaQuery.of(context).size.width / 1.09,
              height: MediaQuery.of(context).size.height / 2,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: _box(currentMode),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 5; i++) ...[
                        Image.asset(
                          controller.images[i].imagePath!,
                          width: 40,
                          height: 62,
                        ),
                      ],
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 24),
                        width: 240,
                        height: 20,
                        child: const ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            value: 2 / 5,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.pink),
                            backgroundColor: Color(0xffD6D6D6),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        width: 240,
                        height: 20,
                        child: const ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            value: 1 / 5,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.yellow),
                            backgroundColor: Color(0xffD6D6D6),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        width: 240,
                        height: 20,
                        child: const ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            value: 2 / 5,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                            backgroundColor: Color(0xffD6D6D6),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 20),
                        width: 240,
                        height: 20,
                        child: const ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            value: 2 / 5,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.orange),
                            backgroundColor: Color(0xffD6D6D6),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        width: 240,
                        height: 20,
                        child: const ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            value: 2 / 5,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.green),
                            backgroundColor: Color(0xffD6D6D6),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  )
                ],
              )

              // child: Row(
              //   children: [
              //     Column(
              //       children: [
              //         for (int i = 0; i < controller.images.length; i++) ...[
              //           Image.asset(
              //             controller.images[i].imagePath!,
              //             width: 40,
              //             height: 80,
              //           )
              //         ]
              //       ],
              //     ),
              //     Column(
              //       children: [
              //         // for (int i = 0;
              //         //     i <
              //         //         controller.diaryDetailData.value
              //         //             .diaryDetailLineEmotionCount!.length;
              //         //     i++) ...[
              //         //   Text(
              //         //       "${controller.diaryDetailData.value.diaryDetailLineEmotionCount![i]}"),
              //         //   Container(
              //         //     margin: const EdgeInsets.symmetric(vertical: 20),
              //         //     width: 300,
              //         //     height: 20,
              //         //     child: ClipRRect(
              //         //         borderRadius:
              //         //             const BorderRadius.all(Radius.circular(10)),
              //         //         child: LinearProgressIndicator(
              //         //             value: (controller.diaryDetailData.value
              //         //                     .diaryDetailLineEmotionCount![i]) /
              //         //                 controller.emotionSum.value,
              //         //             valueColor:
              //         //                 const AlwaysStoppedAnimation<Color>(
              //         //                     Color(0xff00ff00)),
              //         //             backgroundColor: const Color(0xffD6D6D6))),
              //         //   )
              //         // ]
              //         Container(
              //           margin: const EdgeInsets.only(top: 16, bottom: 24),
              //           width: 300,
              //           height: 20,
              //           child: ClipRRect(
              //               borderRadius:
              //                   const BorderRadius.all(Radius.circular(10)),
              //               child: LinearProgressIndicator(
              //                   value: (controller.diaryDetailData.value
              //                           .diaryDetailLineEmotionCount![0]) /
              //                       controller.emotionSum.value,
              //                   valueColor: const AlwaysStoppedAnimation<Color>(
              //                       Colors.pink),
              //                   backgroundColor: const Color(0xffD6D6D6))),
              //         ),
              //         Container(
              //           margin: const EdgeInsets.symmetric(vertical: 20),
              //           width: 300,
              //           height: 20,
              //           child: ClipRRect(
              //               borderRadius:
              //                   const BorderRadius.all(Radius.circular(10)),
              //               child: LinearProgressIndicator(
              //                   value: (controller.diaryDetailData.value
              //                           .diaryDetailLineEmotionCount![1]) /
              //                       controller.emotionSum.value,
              //                   valueColor: const AlwaysStoppedAnimation<Color>(
              //                       Colors.yellow),
              //                   backgroundColor: const Color(0xffD6D6D6))),
              //         ),
              //         Container(
              //           margin: const EdgeInsets.symmetric(vertical: 20),
              //           width: 300,
              //           height: 20,
              //           child: ClipRRect(
              //               borderRadius:
              //                   const BorderRadius.all(Radius.circular(10)),
              //               child: LinearProgressIndicator(
              //                   value: (controller.diaryDetailData.value
              //                           .diaryDetailLineEmotionCount![2]) /
              //                       controller.emotionSum.value,
              //                   valueColor: const AlwaysStoppedAnimation<Color>(
              //                       Colors.blue),
              //                   backgroundColor: const Color(0xffD6D6D6))),
              //         ),
              //         Container(
              //           margin: const EdgeInsets.symmetric(vertical: 20),
              //           width: 300,
              //           height: 20,
              //           child: ClipRRect(
              //               borderRadius:
              //                   const BorderRadius.all(Radius.circular(10)),
              //               child: LinearProgressIndicator(
              //                   value: (controller.diaryDetailData.value
              //                           .diaryDetailLineEmotionCount![3]) /
              //                       controller.emotionSum.value,
              //                   valueColor: const AlwaysStoppedAnimation<Color>(
              //                       Colors.orange),
              //                   backgroundColor: const Color(0xffD6D6D6))),
              //         ),
              //         Container(
              //           margin: const EdgeInsets.symmetric(vertical: 20),
              //           width: 300,
              //           height: 20,
              //           child: ClipRRect(
              //               borderRadius:
              //                   const BorderRadius.all(Radius.circular(10)),
              //               child: LinearProgressIndicator(
              //                   value: (controller.diaryDetailData.value
              //                           .diaryDetailLineEmotionCount![4]) /
              //                       controller.emotionSum.value,
              //                   valueColor: const AlwaysStoppedAnimation<Color>(
              //                       Colors.green),
              //                   backgroundColor: const Color(0xffD6D6D6))),
              //         ),
              //       ],
              //     )
              //   ],
              // )
              );
        });
  }
}
