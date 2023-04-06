import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:test_app/src/config/message.dart';
import 'package:test_app/src/model/diary/post_chatbot_model.dart';
import 'package:test_app/src/model/diary/put_diary_update.dart';
import 'package:test_app/src/services/auth_dio.dart';
import 'package:test_app/src/services/chatbot/chatbot_services.dart';

import '../../model/diary/selected_image.dart';

class ModifyController extends GetxController {
  late TextEditingController textController = TextEditingController();
  late TextEditingController speechController = TextEditingController();
  var isListening = false.obs;
  var speechText = "".obs;
  final SpeechToText? speechToText = SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  final RxBool isChatbotClicked = false.obs;
  final RxBool isChatbotLoading = false.obs;
  final RxInt emotionIndex = 0.obs;
  final storage = const FlutterSecureStorage();
  var diaryScore = 0.obs;
  Timer? timer;
  final RxString diaryText = "".obs;
  RxBool isSelected = true.obs;
  final PutDiaryUpdate diaryUpdateModel = PutDiaryUpdate();
  final RxString chatbotMessage = "안녕하세요 토닥이입니다\n도움이 필요하신가요?".obs;

  var logger = Logger();

  final RxList<SelectedImage> images = [
    SelectedImage(imagePath: "assets/images/happy.png", name: '기쁨'),
    SelectedImage(imagePath: "assets/images/unrest.png", name: '불안'),
    SelectedImage(imagePath: "assets/images/sad.png", name: '슬픔'),
    SelectedImage(imagePath: "assets/images/angry.png", name: '분노'),
    SelectedImage(imagePath: "assets/images/tired.png", name: '피곤'),
  ].obs;

  final RxList<SelectedImage> peopleImages = [
    SelectedImage(imagePath: "assets/images/family.png", name: '가족'),
    SelectedImage(imagePath: "assets/images/friends.png", name: '친구'),
    SelectedImage(imagePath: "assets/images/couple.png", name: '연인'),
    SelectedImage(imagePath: "assets/images/person.png", name: '지인'),
    SelectedImage(imagePath: "assets/images/solo.png", name: '혼자'),
  ].obs;
  final List<dynamic> emotionCountList = [0, 0, 0, 0, 0].obs;

  @override
  void onInit() {
    print("컨트롤러 연결 완료 ${Get.arguments.value.diaryDetailLineEmotionCount}");
    chatbotMessage("안녕하세요 토닥이입니다\n도움이 필요하신가요?");
    textController.text = Get.arguments.value.diaryContent;
    diaryText(Get.arguments.value.diaryContent);

    ChangeGradePoint(Get.arguments.value.diaryScore);
    for (var emotion in Get.arguments.value.diaryEmotion) {
      toggleImage(emotion - 1);
    }
    for (var met in Get.arguments.value.diaryMet) {
      togglePeopleImage(met - 1);
    }
    for (int i = 0;
        i < Get.arguments.value.diaryDetailLineEmotionCount.length;
        i++) {
      emotionCountList[i] = Get.arguments.value.diaryDetailLineEmotionCount[i];
    }
    super.onInit();
  }

  void listen() async {
    isChatbotLoading(false);
    isChatbotClicked(false);
    speechController.text = "";
    speechText.value = "";

    if (!isListening.value) {
      bool available = await speechToText!.initialize(
        onStatus: (val) {
          if (val == "notListening") {
            speechController.text = speechText.value;
          }
        },
        onError: (val) {},
      );

      if (available) {
        isListening.value = true;
        int lastTranscriptionTime = DateTime.now().millisecondsSinceEpoch;
        Timer? timer;

        speechToText!.listen(
          onResult: (val) {
            speechController.text = val.recognizedWords;
            speechText.value = speechController.text;
            lastTranscriptionTime = DateTime.now().millisecondsSinceEpoch;
          },
          onSoundLevelChange: (level) {
            lastTranscriptionTime = DateTime.now().millisecondsSinceEpoch;
          },
        );

        // // 일정 시간 간격으로 종료 여부를 체크하는 타이머 설정
        // Timer.periodic(const Duration(seconds: 1), (timer) {
        //   final currentTime = DateTime.now().millisecondsSinceEpoch;
        //   if (currentTime - lastTranscriptionTime > 2000) {
        //     // 종료 시간 조건을 만족하면 음성 인식 종료
        //     isListening.value = false;

        //     speechToText!.stop();
        //     timer.cancel(); // 타이머 취소
        //   }
        // });
      }
    } else {
      isListening.value = false;
      speechToText!.stop();
    }
  }

  textInput(String text) {
    speechText.value = text;
    isChatbotClicked(false);
    isChatbotLoading(false);
  }

  Chatbot(String text) async {
    if (text == "") {
      Get.snackbar("", "",
          titleText: Message.title("오류"),
          messageText: Message.message("메세지를 입력해주세요"));
    } else {
      isChatbotClicked(true);
      isListening(false);
      final PostChatBotModel model = PostChatBotModel(text: text);
      var data = await ChatbotServices().postText(model);

      if (textController.text.isNotEmpty) {
        textController.text += "\n${speechText.value}";
        diaryText.value += "\n${speechText.value}";
      } else {
        textController.text += speechText.value;
        diaryText.value += speechText.value;
      }
      isChatbotLoading(!isChatbotLoading.value);
      diaryUpdateModel.diaryContent = diaryText.value;
      speechText.value = "";
      speechController.clear();
      emotionIndex(data.emotion);
      print(data.emotion);

      if (data.emotion as int >= 1) {
        emotionCountList[(data.emotion as int) - 1]++;
      }
      speak(chatbotMessage(data.returnText));
    }
  }

  speak(String text) async {
    await flutterTts.setLanguage("ko-KR");
    await flutterTts.setVoice({'name': 'Google 한국의', 'locale': 'ko-KR'});
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  void togglePeopleImage(int index) {
    peopleImages[index].isSelected = !peopleImages[index].isSelected!;
  }

  void toggleImage(int index) {
    images[index].isSelected = !images[index].isSelected!;
  }

  void changeDiaryText(String value) {
    diaryText(value);
  }

  void ChangeGradePoint(int index) {
    diaryScore.value = index;
    isSelected(!false);
  }

  void colorChangeIndex(int index) {}

  diaryModify(String date) {
    diaryUpdateModel.diaryId = Get.arguments.value.diaryId;
    diaryUpdateModel.diaryContent = diaryText.value;
    diaryUpdateModel.diaryScore = diaryScore.value;

    diaryUpdateModel.diaryEmotionIdList = [];

    for (int i = 0; i < images.length; i++) {
      if (images[i].isSelected == true) {
        diaryUpdateModel.diaryEmotionIdList!.add(i + 1);
      }
    }

    diaryUpdateModel.diaryMetIdList = [];

    for (int i = 0; i < peopleImages.length; i++) {
      if (peopleImages[i].isSelected == true) {
        diaryUpdateModel.diaryMetIdList!.add(i + 1);
      }
    }
    diaryUpdateModel.diaryDetailLineEmotionCountList = [];

    diaryUpdateModel.diaryDetailLineEmotionCountList =
        List<int>.from(emotionCountList);

    putDiary(date);
  }

  putDiary(String date) async {
    final accessToken = await storage.read(key: "accessToken");
    final refreshToken = await storage.read(key: "refreshToken");

    try {
      // var dio = await DiaryServices()
      //     .diaryDio(accessToken: accessToken, refreshToken: refreshToken);
      var dio = await authDio();
      final response = await dio.put("/diary/update", data: {
        "diaryId": diaryUpdateModel.diaryId,
        "diaryContent": diaryUpdateModel.diaryContent,
        "diaryScore": diaryUpdateModel.diaryScore,
        "diaryEmotionIdList": diaryUpdateModel.diaryEmotionIdList,
        "diaryMetIdList": diaryUpdateModel.diaryMetIdList,
        "diaryDetailLineEmotionCountList":
            diaryUpdateModel.diaryDetailLineEmotionCountList
      });
      // logger.i('${diaryUpdateModel.diaryId}');
      Get.offNamed('/detail/${diaryUpdateModel.diaryId}', arguments: date);
      // Get.back();
      // DiaryDetailController.
    } on DioError catch (e) {
      logger.e(e.response?.statusCode);
      logger.e(e.response?.data);
      logger.e(e.message);
    }
  }
}
