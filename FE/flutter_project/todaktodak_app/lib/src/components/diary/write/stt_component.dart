import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/diary/diary_write_controller.dart';

class SttComponent extends StatelessWidget {
  SttComponent({super.key});
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

  final controller = Get.put(DiaryWriteController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 12,
      decoration: _box(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    controller.speechText.value,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 10,
                  ),
                ),
              )),
          Obx(() => AvatarGlow(
                animate: controller.isListening.value,
                glowColor: const Color(0xffF1648A),
                endRadius: 45.0,
                duration: const Duration(milliseconds: 2000),
                repeat: true,
                repeatPauseDuration: const Duration(microseconds: 100),
                child: GestureDetector(
                  onTap: () {
                    controller.listen();
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 10),
                      child: Icon(controller.isListening.value == false
                          ? Icons.mic_none
                          : Icons.mic)),
                ),
              ))
        ],
      ),
    );
  }
}
