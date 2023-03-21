import 'dart:convert';

import 'package:get/get.dart';
import 'package:test_app/src/model/calendar/all_diary_model.dart';
import 'package:http/http.dart' as http;

const BASE_URL = 'http://3.36.114.174:8080/api/v1';

class DiaryController extends GetxController {
  static DiaryController get to => Get.find();

  Rx<List<AllDiaryModel>> diaryList = Rx<List<AllDiaryModel>>([]);

  @override
  void onInit() {
    super.onInit();
    fetchDiaryList();
  }

  fetchDiaryList() async {
    print('다이어리 리스트를 가져오는 함수 호출');
    List<AllDiaryModel> diaryListInstances = [];
    final url = Uri.parse('$BASE_URL/diary/calendar/1');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final parsed = jsonDecode(utf8.decode(response.bodyBytes));
      final List<dynamic> allDiary = parsed['data'];
      for (var diary in allDiary) {
        diaryListInstances.add(AllDiaryModel.fromJson(diary));
      }
      diaryList(diaryListInstances);
    } else {
      // throw Error();
      print('다이어리 리스트를 가져오는 함수 호출 실패');
    }
  }

  iterateDiaryList() {
    List<AllDiaryModel> diaryListInstances = diaryList.value;
    return diaryListInstances;
  }
}
