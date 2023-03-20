import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/analysis/analysis_controller.dart';

class AnalysisPage extends GetView<AnalysisController> {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("분석"),
      ),
    );
  }
}
