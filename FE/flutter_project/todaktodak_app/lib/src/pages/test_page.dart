import 'package:flutter/material.dart';
import 'package:test_app/src/components/analysis/drop_down_component.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/test_controller.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final controller = Get.put(TestController(), permanent: true);

  Text getText() {
    return Text('${controller.currentIndex}');
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TestController(), permanent: true);
    return Obx(() => getText());
  }
}
