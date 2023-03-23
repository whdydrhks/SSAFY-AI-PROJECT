import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/setting/setting_controller.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("setting"),
      ),
    );
  }
}
