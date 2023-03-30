import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:test_app/src/services/auth_dio.dart';

import '../../model/testModel.dart';

class AnalysisController extends GetxController {
  static AnalysisController get to => Get.find();
  var logger = Logger(
    printer: PrettyPrinter(methodCount: 1),
  );

  // 현재 년, 월
  RxInt currentYear = DateTime.now().year.obs;
  RxInt currentMonth = DateTime.now().month.obs;

  // 차트를 위한 데이터
  Rx<List<FlSpot>> spots = Rx<List<FlSpot>>([]);

  // 아이콘 top5를 위한 데이터
  RxInt top5Count = 0.obs;
  RxInt emptyCount = 3.obs;
  RxMap<String, int> top5Map = RxMap<String, int>({});

  // 기분&활동 분석을 위한 데이터
  RxInt selectedFeel = 5.obs;
  RxInt leftSideCount = 0.obs;
  RxInt rightSideCount = 0.obs;
  Rx<Map<int, Map<String, int>>> feelActivityMap =
      Rx<Map<int, Map<String, int>>>({});

  // 감정/관계별 분석을 위한 데이터
  RxString selectedFeelOrRelation = 'feel'.obs;
  Rx<Map<String, Map<String, double>>> feelRelationMap =
      Rx<Map<String, Map<String, double>>>({});

  //탭바 데이터
  RxInt selectedTabIndex = 0.obs;

  //연간 탭으로 넘어가기 전의 월을 저장할 변수
  RxInt beforeYearTabMonth = 0.obs;

  @override
  onInit() {
    super.onInit();
    fetchAnalysisData();
  }

  fetchAnalysisData() async {
    // logger.i('분석 데이터를 가져오는 함수 호출 연도: $currentYear 월: $currentMonth');

    try {
      List<FlSpot> allSpots = [];

      var dio = await authDio();
      final response =
          await dio.get('/analyze?year=$currentYear&month=$currentMonth');
      // 차트를 위한 데이터
      final allChartData =
          response.data['data']?['chart']?['$currentYear']?['$currentMonth'];
      if (allChartData == null) {
        spots.value = [];
      } else {
        for (var i = 0; i < allChartData.length; i++) {
          allSpots.add(FlSpot(double.parse(allChartData.keys.elementAt(i)),
              allChartData.values.elementAt(i).toDouble()));
        }
        spots(allSpots);
        // logger.i(
        //     'spots ${spots}\nallSpots $allSpots\n${spots.runtimeType} ${allSpots.runtimeType}');
        update();
      }

      // logger.i('spots ${spots.value}\nallSpots $allSpots');

      // top5를 위한 데이터
      final allTop5Data = response.data!['data']?['top5'];
      // logger.i('allTop5Data $allTop5Data');
      if (allTop5Data == null) {
        top5Map.value = {};
        top5Count.value = 0;
        emptyCount.value = 3;
      } else {
        final Map<String, int> paresdTop5Map = Map<String, int>.from(
          Map<String, dynamic>.from(allTop5Data).map(
            (key, value) => MapEntry<String, int>(key, value as int),
          ),
        );
        top5Map.value = paresdTop5Map;
        final int top5Length = top5Map.length > 5 ? 5 : top5Map.length;
        top5Count.value = top5Length;
        emptyCount.value = 3 - top5Length;
        emptyCount.value = emptyCount.value < 0 ? 0 : emptyCount.value;
        update();
      }

      // logger.i(
      //     'top5Map ${top5Map.value}\ntop5Count $top5Count\nemptyCount $emptyCount');

      // 기분&활동 분석을 위한 데이터
      final allFeelActivityData = response.data!['data']?['icons'];
      if (allFeelActivityData == null) {
        feelActivityMap.value = {};
      } else {
        final parsedFeelActivityData =
            allFeelActivityData.map<int, Map<String, int>>((key, value) {
          final subData = (value as Map<String, dynamic>)
              .map<String, int>((key, value) => MapEntry(key, value as int));
          return MapEntry(int.parse(key), subData);
        });
        feelActivityMap.value = parsedFeelActivityData;
        // logger.i(
        //     '원래 = ${feelActivityMap.value[1]?['연인']}\n테스트 =responseData ${responseData.data.runtimeType}');
        update();
      }

      // logger.i(
      //     '타입: ${parsedFeelActivityData.runtimeType}\n eelActivityMap.value: $feelActivityMap');

      // 감정/관계별 분석을 위한 데이터
      // final allFeelRelationData = response.data?['data']['average'];
      // final Map<String, Map<String, double>> parsedAllFeelRelationData = {
      //   'feel': (allFeelRelationData['feel'] as Map<String, dynamic>)
      //       .cast<String, double>(),
      //   'relation': (allFeelRelationData['relation'] as Map<String, dynamic>)
      //       .cast<String, double>(),
      // };
      // feelRelationMap.value = parsedAllFeelRelationData;
      // logger.i('feelRelationMap: $feelRelationMap\n');

      feelRelationMap.value = {
        "feel": {"기쁨": 3.4, "슬픔": 2.9, "분노": 2.7, "불안": 3.0},
        "relation": {"지인": 2.9, "가족": 3.0, "친구": 3.0, "연인": 3.1, "혼자": 3.0}
      };
      // feelRelationMap.value = {
      //   "feel": {"기쁨": 4.3, "슬픔": 3.0, "피곤": 2.7, "분노": 3.2, "불안": 2.2},
      //   "relation": {"가족": 4.2, "친구": 3.8, "연인": 4.0, "지인": 3.3, "혼자": 3.7}
      // };

      // logger.i(
      //     '타입: ${parsedAllFeelRelationData.runtimeType}\n feelRelationMap.value: $feelRelationMap');
    } on DioError catch (e) {
      logger.e(e.response?.statusCode);
      logger.e(e.response?.data);
      logger.e(e.message);
      // add appropriate error handling logic
    }
  }

  fetchAnalysisData2() {
    // 1초 뒤에 데이터를 가져온다.
    logger.i('fetchAnalysisData2() 호출');
    Future.delayed(Duration(milliseconds: 1000), () {
      logger.i('1초 지났다.');
      // print('분석 데이터를 가져오는 함수 호출');
      spots.value = [
        FlSpot(1.6774193548387097, 5),
        FlSpot(1.903225806451613, 3),
        FlSpot(2.129032258064516, 4),
        FlSpot(2.354838709677419, 2),
      ];

      top5Map.value = {
        '기쁨': 5,
        '가족': 4,
        '분노': 3,
        '친구': 2,
        '연인': 1,
      };

      final int top5Length = top5Map.length > 5 ? 5 : top5Map.length;
      top5Count(top5Length);
      emptyCount(3 - top5Length);
      emptyCount.value = emptyCount.value < 0 ? 0 : emptyCount.value;

      feelRelationMap.value = {
        "feel": {"기쁨": 4.3, "슬픔": 3.0, "피곤": 2.7, "분노": 3.2, "불안": 2.2},
        "relation": {"가족": 4.2, "친구": 3.8, "연인": 4.0, "지인": 3.3, "혼자": 3.7}
      };

      // logger.i('top5Count: $top5Count \n emptyCount: $emptyCount');

      // for (var i = 0; i < 5; i++) {
      //   print(top5Map.keys.elementAt(i));
      //   print(top5Map.values.elementAt(i));
      // }
    });
  }

  testFetchData() {
    spots.value = [
      FlSpot(1.6774193548387097, 5),
      FlSpot(2.903225806451613, 3),
      FlSpot(3.129032258064516, 4),
      FlSpot(4.354838709677419, 2),
      FlSpot(5, 2.2),
      FlSpot(6, 3.6),
      FlSpot(7, 4.2),
      FlSpot(8, 3.8),
      FlSpot(9, 3),
      FlSpot(10, 1.2),
      FlSpot(11, 3.6),
      FlSpot(12, 4.0),
    ];
  }

  void prevMonth() {
    if (currentMonth.value == 1) {
      currentMonth.value = 12;
      currentYear.value -= 1;
    } else {
      currentMonth -= 1;
    }
    // 요청 다시 받나?
    fetchAnalysisData();
  }

  void nextMonth() {
    if (currentMonth.value == 12) {
      currentMonth.value = 1;
      currentYear.value += 1;
    } else {
      currentMonth.value += 1;
    }
    // 요청 다시 받나?
    fetchAnalysisData();
  }

  void changeSelectedFeel(int num) {
    selectedFeel.value = num;
    // logger.i('현재 선택된 평점: $selectedFeel');
  }

  void changeSelectedFeelOrRelation(String str) {
    selectedFeelOrRelation.value = str;
    // logger.i('현재 선택된 감정/관계: $selectedFeelOrRelation');
  }

  void changeSelectedTabIndex(int index) {
    selectedTabIndex.value = index;
    // logger.i('현재 선택된 탭 인덱스: $selectedTabIndex');
  }

  void prevYear() {
    currentYear.value -= 1;
    // 요청 다시 받나?
    fetchAnalysisData2();
  }

  void nextYear() {
    currentYear.value += 1;
    // 요청 다시 받나?
    fetchAnalysisData2();
  }

  void changeCurrentMonthToMinusOne() {
    beforeYearTabMonth(int.parse(currentMonth.value.toString()));
    currentMonth.value = -1;
  }

  void changeCurrentMonthToBefore() {
    currentMonth.value = beforeYearTabMonth.value;
  }
}
