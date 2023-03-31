import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:test_app/src/model/diary/post_chatbot_model.dart';
import 'package:test_app/src/model/diary/put_diary_update.dart';
import 'package:test_app/src/services/chatbot/chatbot_services.dart';
import 'package:test_app/src/services/diary/diary_services.dart';

import '../../components/analysis/feel_relation_bar_chart.dart';
import '../../model/diary/selected_image.dart';

class ModifyController extends GetxController {
  late TextEditingController textController = TextEditingController();
  late TextEditingController speechController = TextEditingController();
  var isListening = false.obs;
  var speechText = "".obs;
  final SpeechToText? speechToText = SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  final List<dynamic> emotionCountList = [0, 0, 0, 0, 0].obs;

  final storage = const FlutterSecureStorage();
  var test = 0.obs;
  Timer? timer;
  final RxString diaryText = "".obs;
  RxBool isSelected = true.obs;
  final PutDiaryUpdate diaryUpdateModel = PutDiaryUpdate();
  final RxString chatbotMessage = "제가 답변드려요".obs;

  final RxList<SelectedImage> images = [
    SelectedImage(imagePath: "assets/images/happy.png", name: '기쁨'),
    SelectedImage(imagePath: "assets/images/sad.png", name: '슬픔'),
    SelectedImage(imagePath: "assets/images/angry.png", name: '분노'),
    SelectedImage(imagePath: "assets/images/unrest.png", name: '불안'),
    SelectedImage(imagePath: "assets/images/tired.png", name: '피곤'),
  ].obs;

  final RxList<SelectedImage> peopleImages = [
    SelectedImage(imagePath: "assets/images/family.png", name: '가족'),
    SelectedImage(imagePath: "assets/images/friends.png", name: '친구'),
    SelectedImage(imagePath: "assets/images/couple.png", name: '연인'),
    SelectedImage(imagePath: "assets/images/person.png", name: '지인'),
    SelectedImage(imagePath: "assets/images/solo.png", name: '혼자'),
  ].obs;

  @override
  void onInit() {
    print("컨트롤러 연결 완료 ${Get.arguments.value}");

    textController.text = Get.arguments.value.diaryContent;
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
    speechText.value = text;
  }

  Chatbot(String text) async {
    print("나오지마 $text");
    if (text.isEmpty) {
      Get.snackbar("오류", "메세지를 입력해주세요");
    } else {
      final PostChatBotModel model = PostChatBotModel(text: text);
      var data = await ChatbotServices().postText(model);
      textController.text += " ${speechText.value}";
      diaryText.value += " ${speechText.value}";
      diaryUpdateModel.diaryContent = diaryText.value;
      if (data.emotion as int >= 1) {
        // print(data.emotion);
        emotionCountList[(data.emotion as int) - 1]++;
      }
      print(data);
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

    putDiary();
  }

  putDiary() async {
    print("바뀌어라 ${diaryText.value}");
    final accessToken = await storage.read(key: "accessToken");
    final refreshToken = await storage.read(key: "refreshToken");

    print(diaryUpdateModel.diaryId);
    print(diaryUpdateModel.diaryContent);
    print(diaryUpdateModel.diaryScore);

    print(diaryUpdateModel.diaryEmotionIdList);
    print(diaryUpdateModel.diaryMetIdList);
    print(diaryUpdateModel.diaryDetailLineEmotionCountList);

    try {
      var dio = await DiaryServices()
          .diaryDio(accessToken: accessToken, refreshToken: refreshToken);
      final response = await dio.put("/diary/update", data: {
        "diaryId": diaryUpdateModel.diaryId,
        "diaryContent": diaryUpdateModel.diaryContent,
        "diaryScore": diaryUpdateModel.diaryScore,
        "diaryEmotionIdList": diaryUpdateModel.diaryEmotionIdList,
        "diaryMetIdList": diaryUpdateModel.diaryMetIdList,
        "diaryDetailLineEmotionCountList":
            diaryUpdateModel.diaryDetailLineEmotionCountList
      });
    } on DioError catch (e) {
      logger.e(e.response?.statusCode);
      logger.e(e.response?.data);
      logger.e(e.message);
    }
  }
  // putDiary() async {
  //   try {
  //     var data = await DiaryServices().putDiary(diaryUpdateModel);
  //     print(data.state);
  //     if (data.state == 200) {
  //       Get.snackbar("수정완료", "수정완료하였습니다.");
  //       // DiaryController.to.getDiaryList();
  //       // update();
  //       Get.offNamed("/dashboard");
  //     }
  //   } catch (e) {
  //     Get.snackbar("오류발생", "$e");
  //   }
  // }
}
