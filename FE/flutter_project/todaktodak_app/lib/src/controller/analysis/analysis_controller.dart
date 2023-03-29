import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

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
  RxInt emptyCount = 0.obs;
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

  @override
  onInit() {
    super.onInit();
    fetchAnalysisData();
  }

  fetchAnalysisData() {
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

    final int top5Length = top5Map.length > 5 ? 5 : top5Map.length;
    top5Count(top5Length);
    emptyCount(3 - top5Length);
    emptyCount.value = emptyCount.value < 0 ? 0 : emptyCount.value;
    // logger.i('top5Count: $top5Count \nemptyCount: $emptyCount');

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
        "feel": {"기쁨": 4.3, "슬픔": 3.0, "우울": 2.7, "분노": 3.2, "불안": 2.2},
        "relation": {"가족": 4.2, "친구": 3.8, "연인": 4.0, "지인": 3.3, "혼자": 3.7}
      };

      // logger.i('top5Count: $top5Count \n emptyCount: $emptyCount');

      // for (var i = 0; i < 5; i++) {
      //   print(top5Map.keys.elementAt(i));
      //   print(top5Map.values.elementAt(i));
      // }
    });
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
    fetchAnalysisData2();
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
}
