import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:test_app/src/config/palette.dart';

// ignore: must_be_immutable
class LineChartSample9 extends StatefulWidget {
  LineChartSample9({super.key});

  late double _minX = 0;
  late double _maxX = 5;

  @override
  State<LineChartSample9> createState() => _LineChartSample9State();
}

class _LineChartSample9State extends State<LineChartSample9> {
  // 더미 데이터 생성
  List<FlSpot> spots = [
    FlSpot(0, 0),
    FlSpot(1, 1),
    FlSpot(2, 4),
    FlSpot(3, 3),
    FlSpot(4, 5),
    FlSpot(5, 4),
    FlSpot(6, 1),
    FlSpot(7, 2),
    FlSpot(8, 3.5),
    FlSpot(9, 4),
    FlSpot(10, 3.2),
  ];

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sep';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Dec';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      fitInside: SideTitleFitInsideData(
        enabled: true,
        axisPosition: 0,
        parentAxisSize: 8,
        distanceFromEdge: 0,
      ),
      child: Text(text,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: min(16, 18 * chartWidth / 300),
          )),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    final style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: min(18, 18 * chartWidth / 300),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(meta.formattedValue, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('widget._minX: ${widget._minX}');
    print('widget._maxX: ${widget._maxX}');
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
        child: Container(
          height: 300,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 2,
                  height: 250,
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
                                return touchedSpots
                                    .map((LineBarSpot touchedSpot) {
                                  final textStyle = TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  );
                                  return LineTooltipItem(
                                    '${touchedSpot.x}, ${touchedSpot.y.toStringAsFixed(2)}',
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
                              spots: spots,
                              isCurved: true,
                              isStrokeCapRound: true,
                              barWidth: 3,
                              belowBarData: BarAreaData(
                                show: false,
                              ),
                              dotData: FlDotData(show: false),
                            ),
                          ],
                          // Y축 정수로만 표시
                          minY: 0,
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
                                reservedSize: 48,
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
                            show: false,
                            drawHorizontalLine: true,
                            drawVerticalLine: true,
                            horizontalInterval: 1,
                            verticalInterval: 5,
                            checkToShowHorizontalLine: (value) {
                              return value.toInt() == 0;
                            },
                            getDrawingHorizontalLine: (_) => FlLine(
                              color: Colors.blue,
                              dashArray: [8, 2],
                              strokeWidth: 0.8,
                            ),
                            getDrawingVerticalLine: (_) => FlLine(
                              color: Colors.yellow,
                              dashArray: [8, 2],
                              strokeWidth: 0.8,
                            ),
                            checkToShowVerticalLine: (value) {
                              return value.toInt() == 0;
                            },
                          ),
                          borderData: FlBorderData(show: false),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
