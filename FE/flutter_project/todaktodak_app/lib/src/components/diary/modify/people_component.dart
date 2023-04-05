import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';
import 'package:test_app/src/controller/diary/diary_modify_controller.dart';

class PeopleComponent extends StatelessWidget {
  const PeopleComponent({Key? key}) : super(key: key);

  BoxDecoration _box(ThemeMode currentMode) {
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
    final controller = Get.put(ModifyController());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: screenHeight / 4,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: _box(currentMode),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "관계",
                    style: TextStyle(
                        fontSize: 24,
                        color: Mode.textMode(currentMode),
                        fontFamily: 'Jua_Regular'),
                  ),
                ),
                Expanded(
                  child: GetBuilder<ModifyController>(builder: (controller) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 9,
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            5,
                            (i) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6.4,
                                            child: GestureDetector(
                                                behavior:
                                                    HitTestBehavior.translucent,
                                                onTap: () {
                                                  controller
                                                      .togglePeopleImage(i);
                                                  controller.update();
                                                },
                                                child: Column(
                                                  children: [
                                                    Obx(() => ClipRect(
                                                          child: ColorFiltered(
                                                            colorFilter: controller
                                                                    .peopleImages[
                                                                        i]
                                                                    .isSelected!
                                                                ? const ColorFilter
                                                                    .mode(
                                                                    Colors
                                                                        .transparent,
                                                                    BlendMode
                                                                        .colorBurn,
                                                                  )
                                                                : ColorFilter.mode(
                                                                    Mode.boxMode(
                                                                        currentMode),
                                                                    BlendMode
                                                                        .saturation),
                                                            child: Image.asset(
                                                              controller
                                                                  .peopleImages[
                                                                      i]
                                                                  .imagePath!,
                                                              width: 48,
                                                              height: 80,
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                            ),
                                                          ),
                                                        )),
                                                  ],
                                                ))),
                                      ],
                                    ),
                                    Center(
                                      child: Text(
                                        controller.peopleImages[i].name!,
                                        style: const TextStyle(
                                            fontFamily: 'Jua_Regular',
                                            fontSize: 16),
                                      ),
                                    )
                                  ],
                                )),
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        });
  }
}
