import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:test_app/src/controller/calendar/calendar_controller.dart';
import 'package:test_app/src/controller/dashboard/dashboard_controller.dart';
import 'package:test_app/src/controller/diary/diary_controller.dart';
import 'package:test_app/src/model/diary/post_chatbot_model.dart';
import 'package:test_app/src/model/diary/post_diary_add.dart';
import 'package:test_app/src/model/diary/selected_image.dart';
import 'package:test_app/src/services/chatbot/chatbot_services.dart';
import 'package:test_app/src/services/diary/diary_services.dart';

import '../../components/analysis/feel_relation_bar_chart.dart';

class DiaryWriteController extends GetxController {
  late TextEditingController textController = TextEditingController();
  late TextEditingController speechController = TextEditingController();
  var isListening = false.obs;
  var speechText = "".obs;
  final SpeechToText? speechToText = SpeechToText();
  final FlutterTts flutterTts = FlutterTts();

  final PostDiaryAdd diaryModel = PostDiaryAdd();
  final storage = const FlutterSecureStorage();
  final List<dynamic> emotionCountList = [0, 0, 0, 0, 0].obs;
  final RxString chatbotMessage = "제가 답변해드릴게요".obs;
  final RxBool isFocused = false.obs;

  var diaryScore = 0.obs;
  Timer? timer;
  final RxString diaryText = "".obs;
  RxBool isSelected = true.obs;
  final userId = "".obs;
  final RxList<SelectedImage> images = [
    SelectedImage(imagePath: "assets/images/happy.png", name: '기쁨'),
    SelectedImage(imagePath: "assets/images/sad.png", name: '슬픔'),
    SelectedImage(imagePath: "assets/images/angry.png", name: '분노'),
    SelectedImage(imagePath: "assets/images/unrest.png", name: '불안'),
    SelectedImage(imagePath: "assets/images/tired.png", name: '피곤'),
  ].obs;

  final RxList<SelectedImage> peopleImages = [
    SelectedImage(imagePath: "assets/images/family.png", name: "가족"),
    SelectedImage(imagePath: "assets/images/friends.png", name: "친구"),
    SelectedImage(imagePath: "assets/images/couple.png", name: '연인'),
    SelectedImage(imagePath: "assets/images/person.png", name: '지인'),
    SelectedImage(imagePath: "assets/images/solo.png", name: '혼자'),
  ].obs;

  @override
  void onInit() async {
    final userIdValue = await storage.read(key: 'userId');
    print("목소리를 사용할 수 있을 거야 ${await flutterTts.getVoices}");
    userId(userIdValue);

    // debounce(speechText, (_) {
    //   testChatbot(speechText.value);
    //   Future.delayed(const Duration(seconds: 1));
    //   textController.text += " ${speechText.value}";
    // }, time: const Duration(seconds: 3));
    super.onInit();
  }

  speak(String text) async {
    await flutterTts.setLanguage("ko-KR");
    await flutterTts.setVoice({'name': 'Google 한국의', 'locale': 'ko-KR'});
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

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
            speechController.text = val.recognizedWords;
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

  textInput(String text) {
    print("머야 $text");
    speechText.value = text;
  }

  changeFocus() {
    isFocused(!isFocused.value);
  }

  Chatbot(String text) async {
    if (text.isEmpty) {
      Get.snackbar("오류", "메세지를 입력해주세요");
    } else {
      final PostChatBotModel model = PostChatBotModel(text: text);
      var data = await ChatbotServices().postText(model);
      print(data);
      textController.text += " ${speechText.value}";
      diaryText.value += " ${speechText.value}";
      diaryModel.diaryContent = diaryText.value;
      if (data.emotion as int >= 1) {
        // print(data.emotion);
        emotionCountList[(data.emotion as int) - 1]++;
      }
      speak(chatbotMessage(data.returnText));
    }
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
    update();
  }

  void changeDiaryText(String value) {
    diaryText(value);
    diaryModel.diaryContent = diaryText.value;
  }

  void ChangeGradePoint(int index) {
    diaryScore.value = index;
    diaryModel.diaryScore = diaryScore.value;
    print(diaryModel.diaryScore);
    isSelected(!false);
  }

  void colorChangeIndex(int index) {}

  diaryWrite() {
    if (diaryModel.diaryScore == null) {
      Get.snackbar("오류", "평점을 선택해주세요");
    } else if (diaryModel.diaryContent == null) {
      Get.snackbar("오류", "다이어리 내용을 입력해주세요");
    } else {
      print(diaryText.value);

      diaryModel.diaryEmotionIdList = [];

      for (int i = 0; i < images.length; i++) {
        if (images[i].isSelected == true) {
          diaryModel.diaryEmotionIdList!.add(i + 1);
        }
      }

      diaryModel.diaryMetIdList = [];

      for (int i = 0; i < peopleImages.length; i++) {
        if (peopleImages[i].isSelected == true) {
          diaryModel.diaryMetIdList!.add(i + 1);
        }
      }
      diaryModel.diaryDetailLineEmotionCountList =
          List<int>.from(emotionCountList);

      print(diaryModel.diaryDetailLineEmotionCountList);

      postDiary();
    }
  }

  postDiary() async {
    if (diaryModel.diaryContent!.isEmpty) {
      Get.snackbar("오류", "일기 작성해주세요");
    } else {
      final accessToken = await storage.read(key: "accessToken");
      final refreshToken = await storage.read(key: "refreshToken");
      try {
        var dio = await DiaryServices()
            .diaryDio(accessToken: accessToken, refreshToken: refreshToken);

        final response = await dio.post("/diary/add", data: {
          "diaryContent": diaryModel.diaryContent,
          "diaryScore": diaryModel.diaryScore,
          "diaryEmotionIdList": diaryModel.diaryEmotionIdList,
          "diaryMetIdList": diaryModel.diaryMetIdList,
          "diaryDetailLineEmotionCountList":
              diaryModel.diaryDetailLineEmotionCountList
        });
      } on DioError catch (e) {
        logger.e(e.response?.statusCode);
        logger.e(e.response?.data);
        logger.e(e.message);
      }
    }
  }
}
