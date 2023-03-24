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

  var diaryListModel = <Datum>[].obs;

  getDiaryList() async {
    try {
      Future.delayed(const Duration(seconds: 2));
      final userId = await storage.read(key: 'userId');
      if (userId != null) {
        var data = await DiaryServices().getDiary(userId);
        if (data.state == 200) {
          diaryListModel.clear();
          for (int i = 0; i < data.data!.length; i++) {
            diaryListModel.add(Datum(
              userId: data.data![i].userId,
              diaryId: data.data![i].diaryId,
              diaryScore: data.data![i].diaryScore,
              diaryCreatedDate: data.data![i].diaryCreatedDate,
              diaryCreatedDayOfWeek: data.data![i].diaryCreatedDayOfWeek,
            ));
          }
        }
      }
    } catch (e) {
      Get.snackbar("오류발생", "$e");
    }
  }
}
