import 'package:flutter/material.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:get/get.dart';

import '../../controller/analysis/analysis_controller.dart';

class TestThreeTabBar extends StatefulWidget {
  final analysisController = Get.find<AnalysisController>();

  TestThreeTabBar({Key? key}) : super(key: key);

  @override
  State<TestThreeTabBar> createState() => _TestThreeTabBarState();
}

class _TestThreeTabBarState extends State<TestThreeTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: Palette.blackTextColor,
      indicatorColor: Palette.blackTextColor,
      unselectedLabelColor: Palette.blackTextColor,
      labelStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Jua_Regular',
      ),
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 24.0),
      indicator: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffF1648A),
            width: 2,
          ),
        ),
      ),
      onTap: (value) {
        widget.analysisController.changeSelectedIconRankingTabIndex(value);
        widget.analysisController.selectedTop5Map();
      },
      controller: _tabController,
      tabs: const [
        Tab(
          text: '전체',
        ),
        Tab(
          text: '감정',
        ),
        Tab(
          text: '관계',
        ),
      ],
    );
  }
}
