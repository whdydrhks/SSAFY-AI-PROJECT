import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/diary/diary_write_controller.dart';

class EmotionComponent extends StatelessWidget {
  const EmotionComponent({Key? key}) : super(key: key);

  BoxDecoration _box(ThemeMode currentMode) {
    return BoxDecoration(
        color: Mode.boxMode(currentMode),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 0.5,
            color: Mode.shadowMode(currentMode),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DiaryWriteController());
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: _box(currentMode),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "감정",
                  style: TextStyle(
                      fontSize: 24,
                      color: Mode.textMode(currentMode),
                      fontFamily: 'Jua_Regular'),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 80,
                  child: GetBuilder<DiaryWriteController>(
                    builder: (controller) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.images.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              controller.toggleImage(index);
                              controller.update();
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: 64,
                                    height: 64,
                                    child: ColorFiltered(
                                      colorFilter:
                                          controller.images[index].isSelected!
                                              ? const ColorFilter.mode(
                                                  Colors.transparent,
                                                  BlendMode.colorBurn,
                                                )
                                              : ColorFilter.mode(
                                                  Mode.boxMode(currentMode),
                                                  BlendMode.saturation,
                                                ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Image.asset(
                                          controller.images[index].imagePath!,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${controller.images[index].name}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Jua_Regular',
                                      color: currentMode == ThemeMode.dark
                                          ? Colors.white
                                          : Palette.blackTextColor),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
