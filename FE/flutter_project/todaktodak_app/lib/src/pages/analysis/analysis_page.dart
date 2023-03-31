import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/components/analysis/feel_activity.dart';
import 'package:test_app/src/components/analysis/icon_scroe.dart';
import 'package:test_app/src/components/analysis/analysis_line_chart.dart';
import 'package:test_app/src/components/analysis/feel_relation_bar_chart.dart';
import 'package:test_app/src/components/analysis/new_icon_scroe.dart';
import 'package:test_app/src/components/analysis/test_one.dart';
import 'package:test_app/src/components/analysis/test_three.dart';
import 'package:test_app/src/components/analysis/test_two.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/analysis/analysis_controller.dart';

import '../../components/analysis/tab_bar_component.dart';

class AnalysisPage extends StatefulWidget {
  AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  final AnalysisController controller =
      Get.put(AnalysisController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    controller.fetchAnalysisData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.greyColor,
        elevation: 0,
        // centerTitle: true,
        title: Obx(() {
          return appTitleWidget(controller);
        }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 72),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: TabBarComponent(analysisController: controller),
              ),
              const SizedBox(
                height: 32,
              ),
              const Center(
                child: Text(
                  '기분 추이 그래프',
                  style: TextStyle(
                    color: Palette.blackTextColor,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              // 기분 추이 그래프
              Obx(
                () {
                  final spots = controller.spots.value;
                  final currentMonth = controller.currentMonth.value;
                  final selectedTabIndex = controller.selectedTabIndex.value;

                  return AbsorbPointer(
                      child: AnalysisLineChart(
                    spots: spots,
                    currentMonth: currentMonth,
                    selectedTabIndex: selectedTabIndex,
                  ));
                },
              ),
              const SizedBox(
                height: 40,
              ),
              const Center(
                child: Text(
                  '아이콘 순위',
                  style: TextStyle(
                    color: Palette.blackTextColor,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              // 아이콘 순위

              Obx(() {
                final emptyCount = controller.emptyCount.value;
                final top5Count = controller.top5Count.value;
                final top5Map = controller.top5Map.value;

                return IconScore(
                  emptyCount: emptyCount,
                  top5Count: top5Count,
                  top5Map: top5Map,
                );
              }),
              SizedBox(
                height: 32,
              ),
              Obx(() {
                final emptyCount = controller.emptyCount.value;
                final top5Count = controller.top5Count.value;
                final top5Map = controller.top5Map.value;

                return TestThree(
                  emptyCount: emptyCount,
                  top5Count: top5Count,
                  top5Map: top5Map,
                );
              }),
              SizedBox(
                height: 32,
              ),
              Obx(() {
                final emptyCount = controller.emptyCount.value;
                final top5Count = controller.top5Count.value;
                final top5Map = controller.top5Map.value;

                return TestTwo(
                  emptyCount: emptyCount,
                  top5Count: top5Count,
                  top5Map: top5Map,
                );
              }),
              SizedBox(
                height: 32,
              ),
              Obx(() {
                final emptyCount = controller.emptyCount.value;
                final top5Count = controller.top5Count.value;
                final top5Map = controller.top5Map.value;

                // return IconScore(
                //   emptyCount: emptyCount,
                //   top5Count: top5Count,
                //   top5Map: top5Map,
                // );

                final feelActivityMap = controller.feelActivityMap.value;
                final selectedFeel = controller.selectedFeel.value;
                final changeSelectedFeel = controller.changeSelectedFeel;
                // return NewIconScore(
                //   changeSelectedFeel: changeSelectedFeel,
                //   feelActivityMap: feelActivityMap,
                //   selectedFeel: selectedFeel,
                // );

                return NewIconScore(
                  emptyCount: emptyCount,
                  top5Count: top5Count,
                  top5Map: top5Map,
                );
              }),
              const SizedBox(
                height: 24,
              ),
              Obx(() {
                final feelActivityMap = controller.feelActivityMap.value;
                final selectedFeel = controller.selectedFeel.value;
                final changeSelectedFeel = controller.changeSelectedFeel;

                return TestOne(
                  changeSelectedFeel: changeSelectedFeel,
                  feelActivityMap: feelActivityMap,
                  selectedFeel: selectedFeel,
                );
              }),
              SizedBox(
                height: 32,
              ),
              // 감정/관계별 기분 평균
              Obx(() {
                final feelRelationMap = controller.feelRelationMap.value;
                final selectedFeelOrRelation =
                    controller.selectedFeelOrRelation.value;
                return FeelRelationBarChart(
                  controller: controller,
                  feelRelationMap: feelRelationMap,
                  selectedFeelOrRelation: selectedFeelOrRelation,
                );
              }),
              const SizedBox(
                height: 8,
              ),
              // 기분&활동 심층 분석
              const Center(
                child: Text(
                  '기분&활동 심층 분석',
                  style: TextStyle(
                    color: Palette.blackTextColor,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Obx(() {
                final feelActivityMap = controller.feelActivityMap.value;
                final selectedFeel = controller.selectedFeel.value;
                final changeSelectedFeel = controller.changeSelectedFeel;

                return FeelActivity(
                  changeSelectedFeel: changeSelectedFeel,
                  feelActivityMap: feelActivityMap,
                  selectedFeel: selectedFeel,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // appTitle 위젯
  Row appTitleWidget(AnalysisController controller) {
    bool isMonthTabSelected = controller.selectedTabIndex.value == 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            isMonthTabSelected ? controller.prevMonth() : controller.prevYear();
            setState(() {});
          },
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child: Center(
              child: Container(
                child: const Icon(
                  Icons.chevron_left_rounded,
                  color: Palette.blackTextColor,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Obx(
          () => Text(
            '${controller.currentYear}년',
            style: const TextStyle(
              color: Palette.blackTextColor,
              fontSize: 24,
            ),
          ),
        ),
        SizedBox(
          width: controller.selectedTabIndex.value == 0 ? 8 : 0,
        ),
        if (controller.selectedTabIndex.value == 0)
          Obx(
            () => Text(
              '${controller.currentMonth}월',
              style: const TextStyle(
                color: Palette.blackTextColor,
                fontSize: 24,
              ),
            ),
          ),
        const SizedBox(
          width: 14,
        ),
        GestureDetector(
          onTap: () {
            isMonthTabSelected ? controller.nextMonth() : controller.nextYear();
            setState(() {});
          },
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child: Center(
              child: Container(
                child: const Icon(
                  Icons.chevron_right_rounded,
                  color: Palette.blackTextColor,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
