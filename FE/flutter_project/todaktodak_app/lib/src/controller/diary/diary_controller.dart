import 'package:get/get.dart';

class DiaryController extends GetxController {
  static DiaryController get to => Get.find();

  Rx<List<Map<String, String>>> diaryList = Rx<List<Map<String, String>>>([]);

  @override
  void onInit() {
    super.onInit();
    fetchDiaryList();
  }

  void fetchDiaryList() {
    diaryList([
      {
        'date': '2023.03.05',
        'day': '일요일',
        'feel': 'happy',
      },
      {
        'date': '2023.03.06',
        'day': '월요일',
        'feel': 'sad',
      },
      {
        'date': '2023.03.07',
        'day': '화요일',
        'feel': 'angry',
      },
      {
        'date': '2023.03.08',
        'day': '수요일',
        'feel': 'upset',
      },
      {
        'date': '2023.03.09',
        'day': '목요일',
        'feel': 'happy',
      },
      {
        'date': '2023.03.10',
        'day': '금요일',
        'feel': 'sad',
      },
      {
        'date': '2023.03.11',
        'day': '토요일',
        'feel': 'angry',
      },
      {
        'date': '2023.03.12',
        'day': '일요일',
        'feel': 'upset',
      },
      {
        'date': '2023.03.13',
        'day': '월요일',
        'feel': 'happy',
      },
      {
        'date': '2023.03.14',
        'day': '화요일',
        'feel': 'sad',
      },
      {
        'date': '2023.03.15',
        'day': '수요일',
        'feel': 'angry',
      },
      {
        'date': '2023.03.16',
        'day': '목요일',
        'feel': 'upset',
      },
      {
        'date': '2023.03.17',
        'day': '금요일',
        'feel': 'happy',
      },
      {
        'date': '2023.03.18',
        'day': '토요일',
        'feel': 'sad',
      },
      {
        'date': '2023.03.19',
        'day': '일요일',
        'feel': 'angry',
      },
      {
        'date': '2023.03.20',
        'day': '월요일',
        'feel': 'upset',
      },
      {
        'date': '2023.03.21',
        'day': '화요일',
        'feel': 'happy',
      },
    ]);
  }

  Iterable<Map<String, String>> iterateDiaryList() {
    Iterable<Map<String, String>> diaryListIterable = diaryList.value;
    return diaryListIterable;
  }
}
