import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/model/diary/get_diary_list_result.dart';

import '../../services/diary/diary_services.dart';

class DiaryController extends GetxController {
  RxString userId = "".obs;
  final storage = const FlutterSecureStorage();
  static DiaryController get to => Get.find();

  final gradeList = [
    "assets/images/score1.png",
    "assets/images/score2.png",
    "assets/images/score3.png",
    "assets/images/score4.png",
    "assets/images/score5.png",
  ].obs;

  final RxList<Datum> diaryListModel = <Datum>[].obs;

  @override
  void onInit() {
    getDiaryList();
    super.onInit();
  }

  @override
  void onReady() {
    print("누구인가");
    super.onReady();
  }

  getDiaryList() async {
    try {
      final userId = await storage.read(key: 'userId');
      if (userId != null) {
        var data = await DiaryServices().getDiary(userId);
        if (data.state == 200) {
          diaryListModel.value = data.data ?? [];
          update();
        }
      }
    } catch (e) {
      Get.snackbar("오류발생", "$e");
    }
  }
}
