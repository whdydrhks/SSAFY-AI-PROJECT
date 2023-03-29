import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:test_app/src/components/analysis/drop_down_component.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/analysis/analysis_controller.dart';

var logger = Logger(
  printer: PrettyPrinter(methodCount: 1),
);

class FeelRelationBarChart extends StatefulWidget {
  final controller;

  FeelRelationBarChart({super.key, this.controller});

  List<Color> get availableColors => const <Color>[
        Colors.purple,
        Colors.yellow,
        Colors.blue,
        Colors.orange,
        Colors.pink,
        Colors.red,
      ];

  final Color barBackgroundColor = Colors.black.withOpacity(0.1);

  final Color barColor = Color(0xffF16A8E);

  // final Color barColor = Colors.purpleAccent;
  // final Color barColor = Color(0xffF16A8E);
  final Color touchedBarColor = Color(0xffEE4471);

  @override
  State<StatefulWidget> createState() => FeelRelationBarChartState();
}

class FeelRelationBarChartState extends State<FeelRelationBarChart> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    // selectedFeelOrRelation 변수에 구독 추가
    widget.controller.selectedFeelOrRelation
        .listen(_onSelectedFeelOrRelationChanged);
  }

  @override
  void dispose() {
    // 구독을 취소
    widget.controller.selectedFeelOrRelation.close();
    super.dispose();
  }

  void _onSelectedFeelOrRelationChanged(String value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Text(
                    '감정/관계별 기분 평균',
                    style: TextStyle(
                      color: Palette.blackTextColor,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 52, bottom: 16),
                      child: BarChart(
                        isPlaying ? randomData() : mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Palette.blackTextColor),
                onPressed: () {
                  setState(() {
                    isPlaying = !isPlaying;
                    if (isPlaying) {
                      refreshState();
                    }
                  });
                },
              ),
            ),
          ),
          Positioned(
            top: 55,
            right: 10,
            child: DropDownComponent(controller: widget.controller),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 0.5 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.white, width: 2)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 5,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  // 여기에 데이터가
  List<BarChartGroupData> showingGroups() {
    bool isFeelSelected =
        widget.controller.selectedFeelOrRelation.value == 'feel';
    double averageItem(String itemKey) {
      return widget.controller.feelRelationMap
          .value[widget.controller.selectedFeelOrRelation.value]![itemKey];
    }

    List<double> nowAverage = [
      averageItem(isFeelSelected ? '기쁨' : '가족'),
      averageItem(isFeelSelected ? '불안' : '친구'),
      averageItem(isFeelSelected ? '슬픔' : '연인'),
      averageItem(isFeelSelected ? '분노' : '지인'),
      averageItem(isFeelSelected ? '우울' : '혼자'),
    ];
    return List.generate(5, (i) {
      switch (i) {
        case 0:
          return makeGroupData(0, nowAverage[0], isTouched: i == touchedIndex);
        case 1:
          return makeGroupData(1, nowAverage[1], isTouched: i == touchedIndex);
        case 2:
          return makeGroupData(2, nowAverage[2], isTouched: i == touchedIndex);
        case 3:
          return makeGroupData(3, nowAverage[3], isTouched: i == touchedIndex);
        case 4:
          return makeGroupData(4, nowAverage[4], isTouched: i == touchedIndex);
        default:
          return throw Error();
      }
    });
  }

  BarChartData mainBarData() {
    bool isFeelSelected =
        widget.controller.selectedFeelOrRelation.value == 'feel';
    List<String> feelOrRelationList = isFeelSelected
        ? ['기쁨', '불안', '슬픔', '분노', '우울']
        : ['가족', '친구', '연인', '지인', '혼자'];

    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.white,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -60,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = feelOrRelationList[0];
                break;
              case 1:
                weekDay = feelOrRelationList[1];
                break;
              case 2:
                weekDay = feelOrRelationList[2];
                break;
              case 3:
                weekDay = feelOrRelationList[3];
                break;
              case 4:
                weekDay = feelOrRelationList[4];
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Palette.blackTextColor,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 60,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.pink,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    bool isFeelSelected =
        widget.controller.selectedFeelOrRelation.value == 'feel';

    Image getNowImage(String imageName) {
      return Image.asset(
        'assets/images/top_five/$imageName.png',
        width: 50,
      );
    }

    Widget img;

    switch (value.toInt()) {
      case 0:
        img = getNowImage(isFeelSelected ? '기쁨' : '가족');
        break;
      case 1:
        img = getNowImage(isFeelSelected ? '불안' : '친구');
        break;
      case 2:
        img = getNowImage(isFeelSelected ? '슬픔' : '연인');
        break;
      case 3:
        img = getNowImage(isFeelSelected ? '분노' : '지인');
        break;
      case 4:
        img = getNowImage(isFeelSelected ? '우울' : '혼자');
        break;

      default:
        img = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: img,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 60,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(5, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 1:
            return makeGroupData(
              1,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 2:
            return makeGroupData(
              2,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 3:
            return makeGroupData(
              3,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 4:
            return makeGroupData(
              4,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );

          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }
}
