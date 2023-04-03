import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:test_app/src/services/auth_dio.dart';

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
  RxInt top5Count = 3.obs;
  RxInt emptyCount = 3.obs;
  RxMap<String, int> top5Map = RxMap<String, int>({});
  RxMap<String, int> newTop5Map = RxMap<String, int>({});

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

  //아이콘 순위 탭바 관련 데이터
  RxInt selectedIconRankingTabIndex = 0.obs;

  @override
  onInit() {
    super.onInit();
    fetchAnalysisData();
    // testeets();
  }

  fetchAnalysisData() async {
    // logger.i('분석 데이터를 가져오는 함수 호출 연도: $currentYear 월: $currentMonth');
    var requestTime = DateTime.now();
    try {
      List<FlSpot> allSpots = [];

      var dio = await authDio();
      final response =
          await dio.get('/analyze?year=$currentYear&month=$currentMonth');

      // 전체 데이터
      final allData = response.data['data'];
      if(allData.length == 0) {
        // logger.i('아무것도 안들어옴');
        spots.value = [];
        top5Map.value = {};
        top5Count.value = 3;
        emptyCount.value = 3;
        feelActivityMap.value = {};
        feelRelationMap.value = {};
        newTop5Map.value = {};
        return null;
      }


      // 차트를 위한 데이터
      final allChartData = response.data['data']?['chart'];
      if (allChartData == null) {
        spots.value = [];
      } else {
        for (var i = 0; i < allChartData.length; i++) {
          allSpots.add(FlSpot(double.parse(allChartData.keys.elementAt(i)),
              double.parse(allChartData.values.elementAt(i))+0.5));
        }
        spots.value = allSpots;
        // logger.i('spots.value: ${spots.value}');
      }
      update();

      // logger.i('spots ${spots.value}\nallSpots $allSpots');

      // top5를 위한 데이터
      final allTop5Data = response.data!['data']?['top5'];
      // logger.i('allTop5Data $allTop5Data');
      if (allTop5Data == null) {
        top5Map.value = {};
        top5Count.value = 3;
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
      }

      update();

      selectedTop5Map();

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
      }
      update();

      // logger.i(
      //     '타입: ${parsedFeelActivityData.runtimeType}\n eelActivityMap.value: $feelActivityMap');

      // 감정/관계별 분석을 위한 데이터
      if (allFeelActivityData == null) {
        feelActivityMap.value = {};
      } else {
        final allFeelRelationData = response.data?['data']['average'];
        final Map<String, Map<String, double>> parsedAllFeelRelationData = {
          'feel': (allFeelRelationData['feel'] as Map<String, dynamic>)
              .cast<String, double>(),
          'relation': (allFeelRelationData['relation'] as Map<String, dynamic>)
              .cast<String, double>(),
        };
        feelRelationMap.value = parsedAllFeelRelationData;
        logger.i('feelRelationMap: $feelRelationMap\n');
      }
      update();

      // feelRelationMap.value = {
      //   "feel": {"기쁨": 3.4, "슬픔": 2.9, "분노": 2.7, "불안": 3.0},
      //   "relation": {"지인": 2.9, "가족": 3.0, "친구": 3.0, "연인": 3.1, "혼자": 3.0}
      // };
      // feelRelationMap.value = {
      //   "feel": {"기쁨": 4.3, "슬픔": 3.0, "피곤": 2.7, "분노": 3.2, "불안": 2.2},
      //   "relation": {"가족": 4.2, "친구": 3.8, "연인": 4.0, "지인": 3.3, "혼자": 3.7}
      // };

      // logger.i(
      //     '타입: ${parsedAllFeelRelationData.runtimeType}\n feelRelationMap.value: $feelRelationMap');
      DateTime responseTime = DateTime.now();
      Duration difference = responseTime.difference(requestTime);
      logger.i('요청과 응답 시간의 차이: ${difference.inMilliseconds}밀리초\n현재시간: $responseTime');
    } on DioError catch (e) {
      logger.e(e.response?.statusCode);
      logger.e(e.response?.data);
      logger.e(e.message);
      // add appropriate error handling logic
    }
  }

  // fetchAnalysisData2() {
  //   // 1초 뒤에 데이터를 가져온다.
  //   logger.i('fetchAnalysisData2() 호출');
  //   Future.delayed(Duration(milliseconds: 1000), () {
  //     logger.i('1초 지났다.');
  //     // print('분석 데이터를 가져오는 함수 호출');
  //     spots.value = [
  //       FlSpot(1.6774193548387097, 5),
  //       FlSpot(1.903225806451613, 3),
  //       FlSpot(2.129032258064516, 4),
  //       FlSpot(2.354838709677419, 2),
  //     ];
  //
  //     top5Map.value = {
  //       '기쁨': 5,
  //       '가족': 4,
  //       '분노': 3,
  //       '친구': 2,
  //       '연인': 1,
  //     };
  //
  //     feelRelationMap.value = {
  //       "feel": {"기쁨": 4.3, "슬픔": 3.0, "피곤": 2.7, "분노": 3.2, "불안": 2.2},
  //       "relation": {"가족": 4.2, "친구": 3.8, "연인": 4.0, "지인": 3.3, "혼자": 3.7}
  //     };
  //
  //     // logger.i('top5Count: $top5Count \n emptyCount: $emptyCount');
  //
  //     // for (var i = 0; i < 5; i++) {
  //     //   print(top5Map.keys.elementAt(i));
  //     //   print(top5Map.values.elementAt(i));
  //     // }
  //   });
  // }

  testeets() {
    // print('분석 데이터를 가져오는 함수 호출');
    spots([
      FlSpot(1.225806451612903, 1),
      FlSpot(1.4516129032258065, 3),
      FlSpot(1.6774193548387097, 4),
      FlSpot(1.903225806451613, 4),
      FlSpot(2.129032258064516, 5),
      FlSpot(2.354838709677419, 3),
      FlSpot(2.5806451612903225, 4),
      FlSpot(2.806451612903226, 2),
      FlSpot(3.2, 3),
      FlSpot(4.5, 5),
      FlSpot(4 + 0.2258064516129032, 5),
      FlSpot(5.2, 2),
      FlSpot(6.1, 2),
    ]);

    top5Map({
      '기쁨': 5,
      '가족': 4,
      // '화남': 3,
      // '친구': 2,
      // '연인': 1,
    });

    selectedTop5Map();

    feelActivityMap({
      5: {
        '기쁨': 12,
        '가족': 11,
        '분노': 11,
        '친구': 10,
        '연인': 9,
        '지인': 9,
        '슬픔': 6,
        '혼자': 5,
        '우울': 2,
        '불안': 1,
      },
      4: {
        '기쁨': 12,
        '가족': 11,
        '분노': 11,
        '친구': 10,
        '연인': 9,
        '지인': 9,
        '슬픔': 6,
        // '혼자': 5,
        // '우울': 2,
        // '불안': 1,
      },
    });

    //Rx<Map<String, Map<String, Map<String, double>>>>
    feelRelationMap({
      "feel": {"기쁨": 4.3, "슬픔": 3.0, "우울": 2.7, "분노": 3.2, "불안": 2.2},
      "relation": {"가족": 4.2, "친구": 3.8, "연인": 4.0, "지인": 3.3, "혼자": 3.7}
    });

    // for (var i = 0; i < 5; i++) {
    //   print(top5Map.keys.elementAt(i));
    //   print(top5Map.values.elementAt(i));
    // }
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
    fetchAnalysisData();
  }

  void nextYear() {
    currentYear.value += 1;
    // 요청 다시 받나?
    fetchAnalysisData();
  }

  void changeCurrentMonthToMinusOne() {
    beforeYearTabMonth(int.parse(currentMonth.value.toString()));
    currentMonth.value = -1;
  }

  void changeCurrentMonthToBefore() {
    currentMonth.value = beforeYearTabMonth.value;
  }

  void changeSelectedIconRankingTabIndex(val) {
    selectedIconRankingTabIndex.value = val;
    // logger.i('현재 선택된 아이콘 랭킹 탭 인덱스: $selectedIconRankingTabIndex');
  }

  void selectedTop5Map() {
    final newMap = Map<String, int>();
    for (int i = 0; i < top5Map.length; i++) {
      final key = top5Map.keys.elementAt(i);
      final value = top5Map.values.elementAt(i);
      if (selectedIconRankingTabIndex.value == 0) {
        newMap[key] = value;
      } else if (selectedIconRankingTabIndex.value == 1 && _shouldIncludeEmotion(key)) {
        newMap[key] = value;
      } else if (selectedIconRankingTabIndex.value == 2 && _shouldIncludeRelation(key)) {
        newMap[key] = value;
      }
    }
    top5Count.value = newMap.length > 3 ? 5 : 3;
    newTop5Map.value = newMap;
  }

  bool _shouldIncludeEmotion(String key) {
    final emotions = ['기쁨', '슬픔', '피곤', '분노', '불안'];
    return emotions.contains(key);
  }

  bool _shouldIncludeRelation(String key) {
    final relations = ['가족', '친구', '연인', '지인', '혼자'];
    return relations.contains(key);
  }
}
