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
}
