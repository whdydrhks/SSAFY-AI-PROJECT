import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:test_app/src/model/calendar/all_diary_model.dart';
import 'package:http/http.dart' as http;

import '../../services/auth_dio.dart';

class DiaryController extends GetxController {
  RxString userId = "".obs;
  final storage = const FlutterSecureStorage();

  static DiaryController get to => Get.find();

  //탭바 데이터
  // 현재 년, 월
  RxInt currentYear = DateTime.now().year.obs;
  RxInt currentMonth = DateTime.now().month.obs;
  RxInt selectedTabIndex = 0.obs;

  //연간 탭으로 넘어가기 전의 월을 저장할 변수
  RxInt beforeYearTabMonth = 0.obs;

  //로거
  var logger = Logger(
    printer: PrettyPrinter(methodCount: 1),
  );

  @override
  void onInit() {
    super.onInit();
    fetchDiaryList();
  }

  Rx<List<AllDiaryModel>> diaryList = Rx<List<AllDiaryModel>>([]);

  fetchDiaryList() async {
    List<AllDiaryModel> diaryListInstances = [];
    // logger.i('다이어리 리스트를 가져오는 함수 호출');
    try {
      var dio = await authDio();
      final response = await dio.get('/diary/calendar');
      final List<dynamic> allDiary = response.data['data'];
      for (var diary in allDiary) {
        diaryListInstances.add(AllDiaryModel.fromJson(diary));
      }
      diaryList.value = diaryListInstances;
    } on DioError catch (e) {
      // logger.e(e.response?.statusCode);
      // logger.e(e.response?.data);
      // logger.e(e.message);
      // add appropriate error handling logic
    }
  }

  iterateDiaryList() {
    List<AllDiaryModel> diaryListInstances = diaryList.value;
    return diaryListInstances;
  }

  List<AllDiaryModel> selectedMonthDiaryList() {
    List<AllDiaryModel> diaryListInstances = diaryList.value;
    List<AllDiaryModel> selectedMonthDiaryList = [];
    for (var diary in diaryListInstances) {
      // String의 2023-03-27 07:22:45.000Z을 DateTime으로 변환
      DateTime diaryDate = DateTime.parse(diary.date);
      if (diaryDate.month == currentMonth.value) {
        selectedMonthDiaryList.add(diary);
      }
    }
    return selectedMonthDiaryList;
  }

  void changeSelectedTabIndex(int index) {
    selectedTabIndex.value = index;
    // logger.i('현재 선택된 탭 인덱스: $selectedTabIndex');
  }

  void prevMonth() {
    if (currentMonth.value == 1) {
      currentMonth.value = 12;
      currentYear.value -= 1;
    } else {
      currentMonth -= 1;
    }
  }

  void nextMonth() {
    if (currentMonth.value == 12) {
      currentMonth.value = 1;
      currentYear.value += 1;
    } else {
      currentMonth.value += 1;
    }
  }

  void prevYear() {
    currentYear.value -= 1;
  }

  void nextYear() {
    currentYear.value += 1;
  }
}
