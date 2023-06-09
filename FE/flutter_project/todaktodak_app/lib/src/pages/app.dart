import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/pages/analysis/analysis_page.dart';
import 'package:test_app/src/pages/calendar/calendar_page.dart';
import 'package:test_app/src/pages/diary/diary_page.dart';
import 'package:test_app/src/pages/setting/setting_page.dart';
import 'package:get/get.dart';
import 'package:test_app/src/pages/test_page.dart';

import '../binding/Init_binding.dart';
import '../controller/app_controller.dart';

class App extends GetView<AppController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('app 빌드');
    // print('지금 인덱스 : ${controller.currentIndex}');

    InitBinding().dependencies();

  
    return Scaffold(
      body: Obx(
        () {
          switch (RouteName.values[controller.currentIndex.value]) {
            case RouteName.Calendar:
              return CalendarPage();
              break;
            case RouteName.Diary:
              return DiaryPage();
              break;

            case RouteName.Analisys:
              return AnalysisPage();
              break;
            case RouteName.Setting:
              return SettingPage();
              // return TestPage();
              break;
          }
          return Container();
        },
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          selectedLabelStyle: const TextStyle(fontFamily: 'Jua_Regular'),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Jua_Regular'),
          unselectedItemColor: const Color(0xff7B7B7B),
          selectedItemColor: const Color(0xffF1648A),
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentIndex.value,
          showSelectedLabels: true,
          onTap: (index) {
            // print('im new $index');
            controller.changePageIndex(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: "달력",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_outlined),
              label: "일기목록",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: "통계",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "설정",
            ),
          ],
        ),
      ),
    );
  }
}
