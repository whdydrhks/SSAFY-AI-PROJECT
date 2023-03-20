import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/dashboard/dashboard_controller.dart';
import 'package:test_app/src/pages/analysis/analysis_page.dart';
import 'package:test_app/src/pages/calendar/calendar_page.dart';
import 'package:test_app/src/pages/diary/diary_page.dart';
import 'package:test_app/src/pages/setting/setting_page.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  _bottomNavigationBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }

  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
            child: IndexedStack(
          index: controller.tabIndex,
          children: [
            CalendarPage(),
            DiaryPage(),
            AnalysisPage(),
            SettingPage(),
          ],
        )),
        bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Color(0xff7B7B7B),
            selectedItemColor: Color(0xffF1648A),
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              _bottomNavigationBarItem(icon: Icons.calendar_today, label: '달력'),
              _bottomNavigationBarItem(
                  icon: Icons.format_list_bulleted_outlined, label: '일기목록'),
              _bottomNavigationBarItem(icon: Icons.leaderboard, label: '통계'),
              _bottomNavigationBarItem(icon: Icons.settings, label: '설정'),
            ]),
      );
    });
  }
}
