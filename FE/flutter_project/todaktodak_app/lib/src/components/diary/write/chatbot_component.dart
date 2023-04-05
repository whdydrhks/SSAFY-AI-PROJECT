import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';
import 'package:test_app/src/controller/diary/diary_write_controller.dart';

class ChatBotComponent extends StatelessWidget {
  const ChatBotComponent({super.key});

  Widget Emotion(var emotion) {
    switch (emotion) {
      case 0:
        return Image.asset(
            Get.find<DiaryWriteController>().images[0].imagePath!);

      case 1:
        return Image.asset(
            Get.find<DiaryWriteController>().images[emotion - 1].imagePath!);
      case 2:
        return Image.asset(
            Get.find<DiaryWriteController>().images[emotion - 1].imagePath!);
      case 3:
        return Image.asset(
            Get.find<DiaryWriteController>().images[emotion - 1].imagePath!);
      case 4:
        return Image.asset(
            Get.find<DiaryWriteController>().images[emotion - 1].imagePath!);
      case 5:
        return Image.asset(
            Get.find<DiaryWriteController>().images[emotion - 1].imagePath!);
      default:
        return Image.asset(
            Get.find<DiaryWriteController>().images[emotion - 1].imagePath!);
    }
  }

  _box(ThemeMode currentMode) {
    return BoxDecoration(
        color: Mode.boxMode(currentMode),
        // color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 0.2,
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
          return Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 6,
                      height: MediaQuery.of(context).size.height / 10,
                      child: controller.isChatbotClicked.value == false
                          ? Image.asset("assets/images/happy.png")
                          : controller.isChabotLoading.value == false
                              ? Center(
                                  child: Image.asset(
                                      "assets/images/consulting.png"),
                                )
                              : Emotion(controller.emotionIndex.value)),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: _box(currentMode),
                    child: controller.isChatbotClicked.value == false
                        ? Text(
                            "상담받고 싶으시다면 저에게 말을 걸어주세요",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Jua_Regular',
                                height: 1,
                                color: Mode.textMode(currentMode)),
                          )
                        : controller.isChabotLoading.value == false
                            ? SizedBox(
                                height: MediaQuery.of(context).size.height / 16,
                                child: const LoadingIndicator(
                                    indicatorType: Indicator.ballBeat,
                                    colors: [
                                      Colors.pink,
                                      Colors.yellow,
                                      Colors.blue
                                    ],
                                    strokeWidth: 1,
                                    backgroundColor: Colors.transparent,
                                    pathBackgroundColor: Colors.yellow),
                              )
                            : SingleChildScrollView(
                                child: Text(
                                  controller.chatbotMessage.value,
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1,
                                    fontFamily: 'Jua_Regular',
                                    color: Mode.textMode(currentMode),
                                    // color: Colors.white,
                                  ),
                                ),
                              ),
                  )
                ],
              ));
        });
  }
}
