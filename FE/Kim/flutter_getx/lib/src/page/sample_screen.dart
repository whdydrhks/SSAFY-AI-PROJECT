import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_getx/src/controller/sample_controller.dart';
import 'package:get/get.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SampleController());
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  "${controller.counter}",
                  style: TextStyle(fontSize: 40),
                )),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: controller.increment, child: Icon(Icons.add)),
                ElevatedButton(
                    onPressed: controller.decrement, child: Icon(Icons.remove)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
