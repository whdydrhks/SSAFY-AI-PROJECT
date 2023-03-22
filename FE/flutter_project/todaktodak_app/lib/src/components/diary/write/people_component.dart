import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/diary/diary_write_controller.dart';

class PeopleComponent extends StatelessWidget {
  const PeopleComponent({super.key});

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
      height: 120,
      decoration: _box(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "사람",
            style: TextStyle(fontSize: 24),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      Get.find<DiaryWriteController>().peopleImages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Get.find<DiaryWriteController>()
                            .togglePeopleImage(index);
                        Get.find<DiaryWriteController>().update();
                      },
                      child: ColorFiltered(
                        colorFilter: Get.find<DiaryWriteController>()
                                .peopleImages[index]
                                .isSelected!
                            ? const ColorFilter.mode(
                                Colors.white,
                                BlendMode.colorBurn,
                              )
                            : const ColorFilter.mode(
                                Colors.white,
                                BlendMode.saturation,
                              ),
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Image.asset(
                                  Get.find<DiaryWriteController>()
                                      .peopleImages[index]
                                      .imagePath!)),
                        ),
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
