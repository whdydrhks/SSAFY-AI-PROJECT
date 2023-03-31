import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';
import 'package:test_app/src/controller/diary/diary_modify_controller.dart';

class PeopleComponent extends StatelessWidget {
  const PeopleComponent({Key? key}) : super(key: key);

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
    final controller = Get.put(ModifyController());
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.8,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: _box(currentMode),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "사람",
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Jua_Regular',
                      color: Mode.textMode(currentMode)),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 80,
                  child: GetBuilder<ModifyController>(
                    builder: (controller) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.peopleImages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              controller.togglePeopleImage(index);
                              controller.update();
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: 64,
                                    height: 64,
                                    child: ColorFiltered(
                                      colorFilter: controller
                                              .peopleImages[index].isSelected!
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
                                          controller
                                              .peopleImages[index].imagePath!,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${controller.peopleImages[index].name}",
                                  style: TextStyle(
                                      fontFamily: 'Jua_Regular',
                                      fontSize: 18,
                                      color: Mode.textMode(currentMode)),
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
