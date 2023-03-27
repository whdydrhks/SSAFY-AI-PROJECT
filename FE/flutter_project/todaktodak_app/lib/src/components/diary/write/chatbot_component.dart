import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/diary/diary_write_controller.dart';

class ChatBotComponent extends StatelessWidget {
  const ChatBotComponent({super.key});
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
    final controller = Get.put(DiaryWriteController());
    return Obx(() => Row(
          children: [
            SizedBox(
                width: 84,
                height: 84,
                child: Image.asset("assets/images/happy.png")),
            const SizedBox(
              width: 8,
            ),
            Container(
              width: 278,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: _box(),
              child: Text(controller.chatbotMessage.value),
            )
          ],
        ));
  }
}
