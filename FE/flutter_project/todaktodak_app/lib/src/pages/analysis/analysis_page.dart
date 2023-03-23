import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/components/analysis/line_chart.dart';
import 'package:test_app/src/components/analysis/line_chart_sample4.dart';
import 'package:test_app/src/components/analysis/top_bottons.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/analysis/analysis_controller.dart';

class AnalysisPage extends GetView<AnalysisController> {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.greyColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '통계',
          style: TextStyle(
            color: Palette.blackTextColor,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            TopButtons(),
            LineChartSample9(),
          ],
        ),
      ),
    );
  }
}
