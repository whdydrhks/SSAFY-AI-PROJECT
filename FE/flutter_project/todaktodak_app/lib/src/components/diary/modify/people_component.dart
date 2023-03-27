import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/diary/diary_modify_controller.dart';

class PeopleComponent extends StatelessWidget {
  const PeopleComponent({Key? key}) : super(key: key);

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
    final controller = Get.put(ModifyController());
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "사람",
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 16,
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
                                colorFilter:
                                    controller.peopleImages[index].isSelected!
                                        ? const ColorFilter.mode(
                                            Colors.transparent,
                                            BlendMode.colorBurn,
                                          )
                                        : const ColorFilter.mode(
                                            Colors.white,
                                            BlendMode.saturation,
                                          ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Image.asset(
                                    controller.peopleImages[index].imagePath!,
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
                            style: const TextStyle(fontSize: 18),
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
  }
}
