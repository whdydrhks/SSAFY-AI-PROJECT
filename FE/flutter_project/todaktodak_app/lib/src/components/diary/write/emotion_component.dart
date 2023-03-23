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

  _test() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(64.0),
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
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "감정",
            style: TextStyle(fontSize: 24),
          ),
          Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 4),
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
                      child: ColorFiltered(
                        colorFilter: controller.images[index].isSelected!
                            ? const ColorFilter.mode(
                                Colors.transparent,
                                BlendMode.colorBurn,
                              )
                            : const ColorFilter.mode(
                                Colors.white,
                                BlendMode.saturation,
                              ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6, right: 6),
                          child: Image.asset(
                            controller.images[index].imagePath!,
                            width: 48,
                            height: 64,
                          ),
                        ),
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
