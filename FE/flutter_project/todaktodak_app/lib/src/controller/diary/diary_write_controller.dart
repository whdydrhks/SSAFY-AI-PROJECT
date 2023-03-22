import 'dart:ffi';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/calendar/calendar_controller.dart';
import 'package:test_app/src/model/diary/post_diary_add.dart';
import 'package:test_app/src/model/diary/selected_image.dart';
import 'package:test_app/src/services/diary/post_diary_services.dart';

class DiaryWriteController extends GetxController {
  late CalendarController calendar;
  final PostDiaryAdd diaryModel = PostDiaryAdd();
  final storage = const FlutterSecureStorage();

  var test = 0.obs;
  final RxString diaryText = "".obs;
  RxBool isSelected = false.obs;
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
  @override
  void onInit() async {
    Map<String, String> allValues = await storage.readAll();
    allValues.forEach((key, value) {
      if (key == "userId") {
        diaryModel.userId = int.tryParse(value);
      }
    });
    debounce(diaryText, (_) {
      diaryModel.diaryContent = _;
    }, time: Duration(seconds: 1));

    super.onInit();
  }

  void togglePeopleImage(int index) {
    // print(index);
    print(peopleImages[index]);
    peopleImages[index].isSelected = !peopleImages[index].isSelected!;
  }

  void toggleImage(int index) {
    // 이미지 선택 토글
    print(images[index]);
    images[index].isSelected = !images[index].isSelected!;
  }

  void changeDiaryText(String value) {
    diaryText(value);
  }

  void testChangeGradePoint(int index) {
    test.value = index;
    diaryModel.diaryScore = test.value;
    print(diaryModel.diaryScore);
    isSelected(!false);
  }

  void colorChangeIndex(int index) {}
  @override
  void dispose() {
    calendar.dispose();
    super.dispose();
  }

  diaryWrite() {
    if (diaryModel.diaryEmotionIdList == null ||
        diaryModel.diaryEmotionIdList != null) {
      diaryModel.diaryEmotionIdList = [];
    }
    for (int i = 0; i < images.length; i++) {
      if (images[i].isSelected == true) {
        diaryModel.diaryEmotionIdList!.add(i + 1);
      }
    }

    if (diaryModel.diaryMetIdList == null ||
        diaryModel.diaryMetIdList != null) {
      diaryModel.diaryMetIdList = [];
    }

    for (int i = 0; i < peopleImages.length; i++) {
      if (peopleImages[i].isSelected == true) {
        diaryModel.diaryMetIdList!.add(i + 1);
      }
    }
    if (diaryModel.diaryDetailLineEmotionCountList == null ||
        diaryModel.diaryDetailLineEmotionCountList != null) {
      diaryModel.diaryDetailLineEmotionCountList = [];
    }

    for (int i = 0; i < 5; i++) {
      diaryModel.diaryDetailLineEmotionCountList!.add(0);
    }
    postDiary();
  }

  postDiary() async {
    try {
      var data = await PostDiaryServices().postDiaryAdd(diaryModel);
      if (data.state == 200) {
        Get.offNamed("/calendar");
        Get.snackbar("성공", "일기가 성공적으로 작성완료 하였습니다.");
      }
    } catch (e) {
      print(e);
    }
  }
}
