import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../config/palette.dart';
import '../../controller/setting/setting_controller.dart';

class SettingPage extends GetView<SettingController> {
  SettingPage({super.key});
  final List<String> items = ["테마설정", "백업하기", "로그아웃"];
  final List<IconData> iconList = [Icons.palette, Icons.backup, Icons.logout];
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                '설정',
                style: TextStyle(
                    color: currentMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                    fontSize: 24,
                    fontFamily: 'Jua_Regular'),
              ),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    if (index == 0) {
                      Get.toNamed("/theme");
                    } else if (index == 1) {
                      Get.toNamed("/backup");
                    }
                  },
                  child: ListTile(
                    title: Row(
                      children: [
                        Icon(
                          iconList[index],
                          color: currentMode == ThemeMode.dark
                              ? Colors.white
                              : Color(0xff212529),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          items[index],
                          style: TextStyle(
                              fontSize: 18,
                              color: currentMode == ThemeMode.dark
                                  ? Colors.white
                                  : Color(0xff212529),
                              fontFamily: 'Jua_Regular'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
