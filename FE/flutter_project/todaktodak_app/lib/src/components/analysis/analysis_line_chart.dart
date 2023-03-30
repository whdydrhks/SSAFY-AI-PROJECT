import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:test_app/src/config/palette.dart';

// ignore: must_be_immutable
class AnalysisLineChart extends StatefulWidget {
  final spots;
  final currentMonth;
  final selectedTabIndex;

  AnalysisLineChart(
      {super.key, this.spots, this.currentMonth, this.selectedTabIndex});

  bool isFirstLoad = false;
  String year = DateTime.now().year.toString();
  String month = DateTime.now().month.toString();

  @override
  State<AnalysisLineChart> createState() => _AnalysisLineChartState();
}

class _AnalysisLineChartState extends State<AnalysisLineChart> {
  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    bool isSelectedMonth = widget.selectedTabIndex == 0;

    if (value % 1 != 0) {
      return Container();
    }
    var text = value.toInt().toString();

    if (isSelectedMonth == true) {
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
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: isSelectedMonth
          ? Text(
              '${widget.currentMonth}/$text',
              style: const TextStyle(
                fontWeight: FontWeight.w100,
                color: Palette.blackTextColor,
                fontSize: 16,
              ),
            )
          : Text(
              '$text',
              style: const TextStyle(
                color: Palette.blackTextColor,
                fontSize: 14,
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
    return Container(
      decoration: const BoxDecoration(
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
                        final textStyle = const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        );
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
                    spots: widget.spots,
                    isCurved: false,
                    isStrokeCapRound: true,
                    barWidth: 3,
                    belowBarData: BarAreaData(
                      show: false,
                    ),
                    dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          if (spot.x == 1) {
                            return FlDotCirclePainter(
                              radius: 2,
                              color: Colors.white,
                              strokeWidth: 2,
                              strokeColor: Palette.pinkColor,
                            );
                          }
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
                minX: 1,
                maxX: widget.selectedTabIndex == 0 ? 7 : 12,
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
                    border: const Border(
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
