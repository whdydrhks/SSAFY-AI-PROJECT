import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Ex extends StatefulWidget {
  const Ex({Key? key}) : super(key: key);

  @override
  _ExState createState() => _ExState();
}

class _ExState extends State<Ex> {
  final List<FlSpot> _chartData = [
    FlSpot(1, 2),
    FlSpot(2, 1),
    FlSpot(3, 4),
    FlSpot(4, 3),
    FlSpot(5, 5),
    FlSpot(6, 4),
    FlSpot(7, 3),
    FlSpot(8, 2),
    FlSpot(9, 1),
    FlSpot(10, 2),
  ];

  double _maxX = 10;
  double _minX = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chart Example'),
      ),
      body: LineChart(
        LineChartData(
          minX: _minX,
          maxX: _maxX,
          lineTouchData: LineTouchData(
            touchSpotThreshold: 5,
            handleBuiltInTouches: true,
            enabled: true,
            // touchCallback: (LineTouchResponse touchResponse) {
            //   if (touchResponse.touchInput is FlPanEnd) {
            //     setState(() {
            //       if (touchResponse.lineBarSpots.length > 1) {
            //         double deltaX = touchResponse.lineBarSpots[1].x -
            //             touchResponse.lineBarSpots[0].x;
            //         _maxX -= deltaX;
            //         _minX -= deltaX;
            //       }
            //     });
            //   }
            // },
          ),
          lineBarsData: [
            LineChartBarData(
              spots: _chartData,
              isCurved: true,
              barWidth: 2,
            ),
          ],
          gridData: FlGridData(
            show: true,
            horizontalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.black12,
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
          ),
        ),
      ),
    );
  }
}
