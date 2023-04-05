import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/services/diary/diary_services.dart';

import '../../components/analysis/feel_relation_bar_chart.dart';
import '../../model/chart/individual_bar.dart';
import '../../model/diary/get_diary_detail_result.dart';
import '../../model/diary/selected_image.dart';

class DiaryDetailController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final diaryDetailData = Data().obs;
  var testDetailData = Data().obs;
  final gradeList = [
    "assets/images/1.png",
    "assets/images/2.png",
    "assets/images/3.png",
    "assets/images/4.png",
    "assets/images/5.png",
  ].obs;
  final storage = const FlutterSecureStorage();
  final emotionSum = 0.obs;
  final RxList<SelectedImage> images = [
    SelectedImage(imagePath: "assets/images/happy.png", name: "기쁨"),
    SelectedImage(imagePath: "assets/images/unrest.png", name: "불안"),
    SelectedImage(imagePath: "assets/images/sad.png", name: "슬픔"),
    SelectedImage(imagePath: "assets/images/angry.png", name: "분노"),
    SelectedImage(imagePath: "assets/images/tired.png", name: "피곤"),
  ].obs;

  final RxList<SelectedImage> peopleImages = [
    SelectedImage(imagePath: "assets/images/family.png"),
    SelectedImage(imagePath: "assets/images/friends.png"),
    SelectedImage(imagePath: "assets/images/couple.png"),
    SelectedImage(imagePath: "assets/images/person.png"),
    SelectedImage(imagePath: "assets/images/solo.png"),
  ].obs;

  final RxList<IndividualBar> barData = <IndividualBar>[].obs;

  @override
  void onInit() {
    final diaryId = Get.parameters["diaryId"];
    getDiaryDetail(diaryId);

    super.onInit();
  }

  void initializedBarData() {
    barData([
      IndividualBar(x: 0, y: 2.0),
      IndividualBar(x: 1, y: 2.0),
      IndividualBar(x: 2, y: 2.0),
      IndividualBar(x: 3, y: 2.0),
      IndividualBar(x: 4, y: 2.0),
    ]);
  }

  getDiaryDetail(var id) async {
    final accessToken = await storage.read(key: "accessToken");
    final refreshToken = await storage.read(key: "refreshToken");

    try {
      var dio = await DiaryServices()
          .diaryDetailDio(accessToken: accessToken, refreshToken: refreshToken);
      final response = await dio.get("/diary/${int.parse(id)}");
      print(response.data["state"]);
      if (response.data["state"] == 401) {
        final newToken = await DiaryServices()
            .tokenRefresh(accessToken: accessToken, refreshToken: refreshToken);
        final request = response.requestOptions
          ..headers['Authorization'] = 'Bearer $newToken';
        await dio.request(request.path,
            options: Options(headers: request.headers));
      } else if (response.data["state"] == 200) {
        if (response.data["data"] != null) {
          diaryDetailData.value = Data.fromJson(response.data["data"]);
          diaryDetailData.value.diaryEmotion!.sort();
          diaryDetailData.value.diaryMet!.sort();
          emotionSum(0);
          for (int i = 0; i < 5; i++) {
            emotionSum.value +=
                diaryDetailData.value.diaryDetailLineEmotionCount![i];
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  deleteDiary(var id) async {
    final accessToken = await storage.read(key: "accessToken");
    final refreshToken = await storage.read(key: "refreshToken");

    try {
      var dio = await DiaryServices()
          .diaryDio(accessToken: accessToken, refreshToken: refreshToken);
      final response =
          await dio.put("/diary/delete", data: {"diaryId": int.parse(id)});
    } on DioError catch (e) {
      logger.e(e.response?.statusCode);
      logger.e(e.response?.data);
      logger.e(e.message);
    }
  }
}
