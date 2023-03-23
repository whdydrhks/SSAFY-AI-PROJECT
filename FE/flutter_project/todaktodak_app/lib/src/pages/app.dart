import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/pages/analysis/analysis_page.dart';
import 'package:test_app/src/pages/calendar/calendar_page.dart';
import 'package:test_app/src/pages/diary/diary_page.dart';
import 'package:test_app/src/pages/setting/setting_page.dart';

import '../controller/app_controller.dart';

class App extends GetView<AppController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              break;
          }
          return Container();
        },
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          unselectedItemColor: Color(0xff7B7B7B),
          selectedItemColor: Color(0xffF1648A),
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentIndex.value,
          showSelectedLabels: true,
          onTap: (index) {
            print('im new $index');
            controller.changePageIndex(index);
          },
          items: [
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
