import 'dart:async';

import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../model/diary/selected_image.dart';

class ModifyController extends GetxController {
  var isListening = false.obs;
  var speechText = "Press the Mic button and start speaking".obs;
  final SpeechToText? speechToText = SpeechToText();
  var test = 0.obs;
  Timer? timer;
  final RxString diaryText = "".obs;
  RxBool isSelected = true.obs;

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
    print("컨트롤러 연결 완료 ${Get.arguments}");
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
    isSelected(!false);
  }

  void colorChangeIndex(int index) {}

  diaryModify() {}
}
