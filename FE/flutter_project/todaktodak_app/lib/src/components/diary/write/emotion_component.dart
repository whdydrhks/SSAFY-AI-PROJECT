import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/diary/diary_write_controller.dart';

class EmotionComponent extends StatelessWidget {
  const EmotionComponent({Key? key}) : super(key: key);

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
    return Container(
      width: 360,
      height: 240,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "평점",
            style: TextStyle(fontSize: 24),
          ),
          Expanded(
            child: GetBuilder<DiaryWriteController>(
              init: DiaryWriteController(),
              builder: (controller) {
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      Get.find<DiaryWriteController>().images.map((image) {
                    return GestureDetector(
                        onTap: () {
                          // 이미지 선택 토글
                          controller.toggleImage(image);
                          // UI를 갱신
                          controller.update();
                        },
                        child: Obx(
                          () => ColorFiltered(
                            colorFilter: controller
                                    .images[controller.images.indexOf(image)]
                                    .isSelected!
                                ? const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.colorBurn,
                                  )
                                : const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.saturation,
                                  ),
                            child: Image.asset(
                              image.imagePath!,
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ));
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
