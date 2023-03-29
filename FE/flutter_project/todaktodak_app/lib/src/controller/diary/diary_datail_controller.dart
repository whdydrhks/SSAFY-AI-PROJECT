import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/services/diary/diary_services.dart';

import '../../components/analysis/feel_relation_bar_chart.dart';
import '../../model/chart/individual_bar.dart';
import '../../model/diary/get_diary_detail_result.dart';
import '../../model/diary/selected_image.dart';

class DiaryDetailController extends GetxController {
  var diaryDetailData = Data().obs;
  final gradeList = [
    "assets/images/score1.png",
    "assets/images/score2.png",
    "assets/images/score3.png",
    "assets/images/score4.png",
    "assets/images/score5.png",
  ].obs;
  final storage = const FlutterSecureStorage();
  final RxList<SelectedImage> images = [
    SelectedImage(imagePath: "assets/images/happy.png"),
    SelectedImage(imagePath: "assets/images/embarr.png"),
    SelectedImage(imagePath: "assets/images/sad.png"),
    SelectedImage(imagePath: "assets/images/angry.png"),
    SelectedImage(imagePath: "assets/images/nomal.png"),
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
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

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
    final refreshTokenExpirationTime =
        await storage.read(key: "refreshTokenExpirationTime");
    try {
      var dio = await DiaryServices().diaryDetailDio(
          accessToken, refreshToken, refreshTokenExpirationTime, id);

      final response = await dio.get("/diary/$id");
    } on DioError catch (e) {
      logger.e(e.response?.statusCode);
      logger.e(e.response?.data);
      logger.e(e.message);
    }
  }

  deleteDiary(var id) async {
    final accessToken = await storage.read(key: "accessToken");
    final refreshToken = await storage.read(key: "refreshToken");
    final refreshTokenExpirationTime =
        await storage.read(key: "refreshTokenExpirationTime");
    try {
      var dio = await DiaryServices()
          .diaryDio(accessToken, refreshToken, refreshTokenExpirationTime);
      final response =
          await dio.put("/diary/delete", data: {"diaryId": int.parse(id)});
    } on DioError catch (e) {
      logger.e(e.response?.statusCode);
      logger.e(e.response?.data);
      logger.e(e.message);
    }
  }
  // getDiaryDetail(var id) async {
  //   try {
  //     var data = await DiaryServices().getDiaryDetail(id);
  //     if (data.state == 200) {
  //       diaryDetailData.value = data.data!;
  //       diaryDetailData.value.diaryEmotion!.sort();
  //       diaryDetailData.value.diaryMet!.sort();
  //       print("데이터 저장했다 $diaryDetailData");
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // deleteDiary(var id) async {
  //   try {
  //     var data = await DiaryServices().deleteDiary(id);
  //     if (data.state == 200) {
  //       Get.snackbar("삭제", "해당 일기 삭제 완료하였습니다.");

  //       Get.delete<DiaryDetailController>();
  //       Get.offNamed("/dashboard");
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
