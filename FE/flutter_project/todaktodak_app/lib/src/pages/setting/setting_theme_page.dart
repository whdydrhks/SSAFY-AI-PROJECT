import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/palette.dart';

class SettingThemePage extends StatelessWidget {
  const SettingThemePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  '테마 설정',
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Jua_Regular',
                      color: currentMode == ThemeMode.dark
                          ? Colors.white
                          : Palette.blackTextColor),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    size: 24,
                    color: currentMode == ThemeMode.dark
                        ? Colors.white
                        : Palette.blackTextColor,
                  ),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: SwitchListTile(
                  title: Text(
                    currentMode == ThemeMode.dark ? '어두운 테마' : '밝은 테마',
                    style: TextStyle(fontSize: 18, fontFamily: 'Jua_Regular'),
                  ),
                  value: currentMode == ThemeMode.dark,
                  onChanged: (value) {
                    MyApp.themeNotifier.value =
                        value ? ThemeMode.dark : ThemeMode.light;
                  },
                ),
              ));
        });
  }
}
