import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/components/analysis/icon_scroe.dart';
import 'package:test_app/src/components/analysis/line_chart.dart';
import 'package:test_app/src/components/analysis/line_chart_sample4.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/analysis/analysis_controller.dart';

class AnalysisPage extends StatefulWidget {
  AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  @override
  Widget build(BuildContext context) {
    final AnalysisController controller = Get.put(AnalysisController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.greyColor,
        elevation: 0,
        centerTitle: true,
        title: appTitleWidget(controller),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                '평점 추이 그래프',
                style: TextStyle(
                  color: Palette.blackTextColor,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            LineChartSample9(controller: controller),
            SizedBox(
              height: 24,
            ),
            Center(
              child: Text(
                '아이콘 순위',
                style: TextStyle(
                  color: Palette.blackTextColor,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            IconScore(controller: controller),
            BarChartSample1(),
          ],
        ),
      ),
    );
  }

  // appTitle 위젯
  Row appTitleWidget(AnalysisController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            controller.prevMonth();
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
                child: Icon(
                  Icons.chevron_left_rounded,
                  color: Palette.blackTextColor,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 14,
        ),
        Obx(
          () => Text(
            '${controller.currentYear}년',
            style: TextStyle(
              color: Palette.blackTextColor,
              fontSize: 24,
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Obx(
          () => Text(
            '${controller.currentMonth}월',
            style: TextStyle(
              color: Palette.blackTextColor,
              fontSize: 24,
            ),
          ),
        ),
        SizedBox(
          width: 14,
        ),
        GestureDetector(
          onTap: () {
            controller.nextMonth();
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
                child: Icon(
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
