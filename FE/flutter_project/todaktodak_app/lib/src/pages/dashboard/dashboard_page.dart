import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/dashboard/dashboard_controller.dart';
import 'package:test_app/src/pages/analysis/analysis_page.dart';
import 'package:test_app/src/pages/calendar/calendar_page.dart';
import 'package:test_app/src/pages/diary/diary_page.dart';
import 'package:test_app/src/pages/setting/setting_page.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  _bottomNavigationBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }

  @override
  void initState() {
    Get.find<DashBoardController>().test();
    super.initState();
  }

  @override
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
            selectedLabelStyle: TextStyle(fontFamily: 'Jua_Regular'),
            unselectedLabelStyle: TextStyle(fontFamily: 'Jua_Regular'),
            unselectedItemColor: const Color(0xff7B7B7B),
            selectedItemColor: const Color(0xffF1648A),
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
