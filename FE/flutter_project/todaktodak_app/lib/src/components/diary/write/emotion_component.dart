import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/diary/diary_write_controller.dart';

class EmotionComponent extends StatelessWidget {
  const EmotionComponent({Key? key}) : super(key: key);

  BoxDecoration _box() {
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
    final controller = Get.put(DiaryWriteController());
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "감정",
            style: TextStyle(fontSize: 24),
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
                                        : const ColorFilter.mode(
                                            Colors.white,
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
