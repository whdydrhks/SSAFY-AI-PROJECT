import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class AnalysisController extends GetxController {
  static AnalysisController get to => Get.find();

  // 현재 년, 월
  RxInt currentYear = DateTime.now().year.obs;
  RxInt currentMonth = DateTime.now().month.obs;

  // 차트를 위한 데이터
  Rx<List<FlSpot>> spots = Rx<List<FlSpot>>([]);

  // 아이콘 top5를 위한 데이터
  RxInt top5Count = 0.obs;
  RxMap<String, int> top5Map = RxMap<String, int>({});

  @override
  onInit() {
    super.onInit();
    fetchAnalysisData();
  }

  fetchAnalysisData() {
    print('분석 데이터를 가져오는 함수 호출');
    spots([
      FlSpot(1, 1),
      FlSpot(1.225806451612903, 1),
      FlSpot(1.4516129032258065, 3),
      FlSpot(1.6774193548387097, 4),
      FlSpot(1.903225806451613, 4),
      FlSpot(2.129032258064516, 5),
      FlSpot(2.354838709677419, 3),
      FlSpot(2.5806451612903225, 4),
      FlSpot(2.806451612903226, 2),
      FlSpot(3, 3),
      FlSpot(4, 5),
      FlSpot(4 + 0.2258064516129032, 5),
      // FlSpot(5, 2),
      // FlSpot(6, 2),
    ]);

    top5Count(5);
    top5Map({
      '행복': 5,
      '가족': 4,
      '화남': 3,
      '친구': 2,
      '연인': 1,
    });

    for (var i = 0; i < 5; i++) {
      print(top5Map.keys.elementAt(i));
      print(top5Map.values.elementAt(i));
    }
  }

  fetchAnalysisData2() {
    print('분석 데이터를 가져오는 함수 호출');
    spots([
      FlSpot(1, 1),
      FlSpot(1.225806451612903, 1),
      FlSpot(1.4516129032258065, 2),
      FlSpot(1.6774193548387097, 5),
      FlSpot(1.903225806451613, 3),
      FlSpot(2.129032258064516, 4),
      FlSpot(2.354838709677419, 2),
      FlSpot(2.5806451612903225, 5),
      FlSpot(2.806451612903226, 3),
      FlSpot(3, 4),
      FlSpot(4, 2),
      FlSpot(4 + 0.2258064516129032, 5),
      // FlSpot(5, 2),
      // FlSpot(6, 2),
    ]);
  }

  void prevMonth() {
    if (currentMonth.value == 1) {
      currentMonth(12);
      currentYear(currentYear.value - 1);
    } else {
      currentMonth(currentMonth.value - 1);
    }
    // 요청 다시 받나?
    fetchAnalysisData2();
  }

  void nextMonth() {
    if (currentMonth.value == 12) {
      currentMonth(1);
      currentYear(currentYear.value + 1);
    } else {
      currentMonth(currentMonth.value + 1);
    }
    // 요청 다시 받나?
    // fetchAnalysisData();
  }
}
