import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:test_app/src/config/palette.dart';

// ignore: must_be_immutable
class LineChartSample9 extends StatefulWidget {
  final controller;

  LineChartSample9({super.key, this.controller});

  List<String> _bottomTitles = [];
  bool isFirstLoad = false;
  String year = DateTime.now().year.toString();
  String month = DateTime.now().month.toString();

  @override
  State<LineChartSample9> createState() => _LineChartSample9State();
}

class _LineChartSample9State extends State<LineChartSample9> {
  // 더미 데이터 생성

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    if (value % 1 != 0) {
      return Container();
    }
    var text = value.toInt().toString();

    switch (text) {
      case '1':
        text = '01';
        break;
      case '2':
        text = '06';
        break;
      case '3':
        text = '11';
        break;
      case '4':
        text = '16';
        break;
      case '5':
        text = '21';
        break;
      case '6':
        text = '26';
        break;
      case '7':
        text = '31';
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(
        '${widget.controller.currentMonth}/$text',
        style: TextStyle(
          fontWeight: FontWeight.w100,
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Image.asset(
        'assets/images/score/${value.toInt().toString()}.png',
        width: 42,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('chart 빌드');
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: 300,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 0,
          bottom: 0,
          right: 40,
          top: 35,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  touchSpotThreshold: 5,
                  handleBuiltInTouches: true,
                  enabled: true,
                  getTouchLineEnd: (data, index) => 4,
                  touchTooltipData: LineTouchTooltipData(
                    maxContentWidth: 100,
                    tooltipBgColor: Colors.white,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((LineBarSpot touchedSpot) {
                        final textStyle = TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        );
                        print(touchedSpot.x);
                        String text = '';

                        return LineTooltipItem(
                          '${touchedSpot.x},$text, ${touchedSpot.y.toStringAsFixed(2)}',
                          textStyle,
                        );
                      }).toList();
                    },
                  ),
                  getTouchLineStart: (data, index) => 0,
                ),
                lineBarsData: [
                  LineChartBarData(
                    color: Palette.pinkColor,
                    spots: widget.controller.spots.value,
                    isCurved: false,
                    isStrokeCapRound: true,
                    barWidth: 3,
                    belowBarData: BarAreaData(
                      show: false,
                    ),
                    dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 2,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: Palette.pinkColor,
                          );
                        }),
                  ),
                ],
                // Y축 정수로만 표시
                minY: 1,
                maxY: 5,
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return leftTitleWidgets(
                            value, meta, constraints.maxWidth);
                      },
                      reservedSize: 55,
                    ),
                    drawBehindEverything: true,
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        // print(value);
                        return bottomTitleWidgets(
                            value, meta, constraints.maxWidth);
                      },
                      reservedSize: 50,
                      interval: 1,
                    ),
                    drawBehindEverything: true,
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  //x축 가이드 라인
                  verticalInterval: 1,
                  horizontalInterval: 10,
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.5),
                    strokeWidth: 1,
                  ),
                  // 라인 색깔 변경
                  show: true,
                ),
                borderData: FlBorderData(
                    show: true,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      left: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
