import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:test_app/src/model/diary/post_chatbot_model.dart';
import 'package:test_app/src/model/diary/post_diary_add.dart';
import 'package:test_app/src/model/diary/selected_image.dart';
import 'package:test_app/src/services/chatbot/chatbot_services.dart';
import 'package:test_app/src/services/diary/diary_services.dart';

import '../../config/message.dart';

final logger = Logger();

class DiaryWriteController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late TextEditingController textController = TextEditingController();
  late TextEditingController speechController = TextEditingController();
  var isListening = false.obs;
  var speechText = "".obs;
  final SpeechToText? speechToText = SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  final RxBool isChatbotClicked = false.obs;
  final RxBool isChabotLoading = false.obs;
  final RxString selectedDay = "".obs;
  final PostDiaryAdd diaryModel = PostDiaryAdd();
  final storage = const FlutterSecureStorage();
  final List<dynamic> emotionCountList = [0, 0, 0, 0, 0].obs;
  final RxString chatbotMessage = "제가 답변해드릴게요".obs;
  final RxBool isFocused = false.obs;
  final RxInt emotionIndex = 0.obs;
  var diaryScore = 0.obs;
  Timer? timer;
  final RxString diaryText = "".obs;
  RxBool isSelected = true.obs;
  String teststt = "";
  final userId = "".obs;

  final RxList<SelectedImage> images = [
    SelectedImage(imagePath: "assets/images/happy.png", name: '기쁨'),
    SelectedImage(imagePath: "assets/images/unrest.png", name: '불안'),
    SelectedImage(imagePath: "assets/images/sad.png", name: '슬픔'),
    SelectedImage(imagePath: "assets/images/angry.png", name: '분노'),
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

    userId(userIdValue);

    super.onInit();
  }

  speak(String text) async {
    await flutterTts.setLanguage("ko-KR");
    await flutterTts.setVoice({'name': 'Google 한국의', 'locale': 'ko-KR'});
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  void listen() async {
    isChabotLoading(false);
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
    speechText.value = "";
    speechText.value = text;
    isChabotLoading(false);
    isChatbotClicked(false);
  }

  changeFocus() {
    isFocused(!isFocused.value);
  }

  Chatbot(String text) async {
    speechToText!.cancel();
    if (text == "") {
      Get.snackbar("", "",
          titleText: Message.title("오류"),
          messageText: Message.message("메세지를 입력해주세요"));
    } else {
      isChatbotClicked(true);
      isListening(false);
      final PostChatBotModel model = PostChatBotModel(text: text);
      var data = await ChatbotServices().postText(model);
      isChabotLoading(!isChabotLoading.value);
      Future.delayed(const Duration(seconds: 1));

      print(data);
      speechToText!.cancel();
      if (textController.text.isNotEmpty) {
        textController.text += "\n${speechText.value}";
        diaryText.value += "\n${speechText.value}";
      } else {
        textController.text += speechText.value;
        diaryText.value += speechText.value;
      }
      diaryModel.diaryContent = diaryText.value;
      speechText.value = "";
      speechController.clear();

      emotionIndex(data.emotion);
      if (data.emotion as int >= 1) {
        emotionCountList[(data.emotion as int) - 1]++;
      }
      speak(chatbotMessage(data.returnText));
    }
  }

  void togglePeopleImage(int index) {
    peopleImages[index].isSelected = !peopleImages[index].isSelected!;
  }

  void toggleImage(int index) {
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
      selectedDay(Get.arguments.toString().substring(0, 10));
      diaryModel.diaryCreateDate = selectedDay.value;

      postDiary();
    }
  }

  postDiary() async {
    if (diaryModel.diaryContent! == null) {
      Get.snackbar("오류", "일기 작성해주세요");
    } else {
      final accessToken = await storage.read(key: "accessToken");
      final refreshToken = await storage.read(key: "refreshToken");
      logger.i('액세스 토큰: $accessToken');
      try {
        var dio = await DiaryServices()
            .diaryDio(accessToken: accessToken, refreshToken: refreshToken);
        dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
        ));
        final response = await dio.post("/diary/add", data: {
          "diaryContent": diaryModel.diaryContent,
          "diaryScore": diaryModel.diaryScore,
          "diaryEmotionIdList": diaryModel.diaryEmotionIdList,
          "diaryMetIdList": diaryModel.diaryMetIdList,
          "diaryCreateDate": diaryModel.diaryCreateDate,
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
