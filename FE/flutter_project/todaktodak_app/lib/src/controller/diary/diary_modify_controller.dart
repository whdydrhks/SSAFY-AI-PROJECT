import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:test_app/src/controller/diary/diary_controller.dart';
import 'package:test_app/src/model/diary/put_diary_update.dart';
import 'package:test_app/src/services/diary/diary_services.dart';

import '../../model/diary/selected_image.dart';

class ModifyController extends GetxController {
  late TextEditingController diaryContentController;
  var isListening = false.obs;
  var speechText = "Press the Mic button and start speaking".obs;
  final SpeechToText? speechToText = SpeechToText();
  var test = 0.obs;
  Timer? timer;
  final RxString diaryText = "".obs;
  RxBool isSelected = true.obs;
  final PutDiaryUpdate diaryUpdateModel = PutDiaryUpdate();
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

  void listen() async {
    if (!isListening.value) {
      bool available = await speechToText!.initialize(
        onStatus: (val) {},
        onError: (val) {},
      );
      if (available) {
        isListening.value = true;
        int lastTranscriptionTime = DateTime.now().millisecondsSinceEpoch;
        speechToText!.listen(
          onResult: (val) {
            speechText.value = val.recognizedWords;
            lastTranscriptionTime = DateTime.now().millisecondsSinceEpoch;
          },
          onSoundLevelChange: (level) {
            lastTranscriptionTime = DateTime.now().millisecondsSinceEpoch;
          },
        );
        Future.delayed(const Duration(seconds: 1));
        // 일정 시간 간격으로 종료 여부를 체크하는 타이머 설정
        Timer.periodic(const Duration(seconds: 1), (timer) {
          final currentTime = DateTime.now().millisecondsSinceEpoch;
          if (currentTime - lastTranscriptionTime > 2000) {
            // 종료 시간 조건을 만족하면 음성 인식 종료
            isListening.value = false;

            speechToText!.stop();
            timer.cancel(); // 타이머 취소
          }
        });
      }
    } else {
      isListening.value = false;
      speechToText!.stop();
    }
  }

  @override
  void onInit() {
    print("컨트롤러 연결 완료 ${Get.arguments.value}");
    diaryContentController = TextEditingController();
    diaryContentController.text = Get.arguments.value.diaryContent;
    diaryText(Get.arguments.value.diaryContent);
    testChangeGradePoint(Get.arguments.value.diaryScore);
    for (var emotion in Get.arguments.value.diaryEmotion) {
      toggleImage(emotion - 1);
    }
    for (var met in Get.arguments.value.diaryMet) {
      togglePeopleImage(met - 1);
    }

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
    print("수정이욤 $diaryText");
  }

  void testChangeGradePoint(int index) {
    test.value = index;
    isSelected(!false);
  }

  void colorChangeIndex(int index) {}

  diaryModify() {
    diaryUpdateModel.diaryId = Get.arguments.value.diaryId;
    diaryUpdateModel.diaryContent = diaryText.value;
    diaryUpdateModel.diaryScore = test.value;
    if (diaryUpdateModel.diaryEmotionIdList == null ||
        diaryUpdateModel.diaryEmotionIdList != null) {
      diaryUpdateModel.diaryEmotionIdList = [];
    }
    for (int i = 0; i < images.length; i++) {
      if (images[i].isSelected == true) {
        diaryUpdateModel.diaryEmotionIdList!.add(i + 1);
      }
    }

    if (diaryUpdateModel.diaryMetIdList == null ||
        diaryUpdateModel.diaryMetIdList != null) {
      diaryUpdateModel.diaryMetIdList = [];
    }

    for (int i = 0; i < peopleImages.length; i++) {
      if (peopleImages[i].isSelected == true) {
        diaryUpdateModel.diaryMetIdList!.add(i + 1);
      }
    }

    if (diaryUpdateModel.diaryDetailLineEmotionCountList == null ||
        diaryUpdateModel.diaryDetailLineEmotionCountList != null) {
      diaryUpdateModel.diaryDetailLineEmotionCountList = [];
    }

    for (int i = 0; i < 5; i++) {
      diaryUpdateModel.diaryDetailLineEmotionCountList!.add(0);
    }

    putDiary();
  }

  putDiary() async {
    try {
      var data = await DiaryServices().putDiary(diaryUpdateModel);
      print(data.state);
      if (data.state == 200) {
        Get.snackbar("수정완료", "수정완료하였습니다.");
        DiaryController.to.getDiaryList();
        update();
        Get.offNamed("/dashboard");
      }
    } catch (e) {
      Get.snackbar("오류발생", "$e");
    }
  }
}
