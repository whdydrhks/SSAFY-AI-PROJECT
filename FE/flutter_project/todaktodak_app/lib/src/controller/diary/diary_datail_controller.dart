import 'package:get/get.dart';
import 'package:test_app/src/services/diary/diary_services.dart';

import '../../model/diary/get_diary_detail_result.dart';
import '../../model/diary/selected_image.dart';

class DiaryDetailController extends GetxController {
  var diaryDetailData = Data().obs;
  final gradeList = [
    "assets/images/score1.png",
    "assets/images/score2.png",
    "assets/images/score3.png",
    "assets/images/score4.png",
    "assets/images/score5.png",
  ].obs;

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
  void onInit() {
    final diaryId = Get.parameters["diaryId"];
    // getDiaryDetail(diaryId);
    super.onInit();
  }

  getDiaryDetail(var id) async {
    try {
      var data = await DiaryServices().getDiaryDetail(id);
      if (data.state == 200) {
        diaryDetailData(Data(
          userId: data.data!.userId,
          diaryId: data.data!.diaryId,
          diaryContent: data.data!.diaryContent,
          diaryScore: data.data!.diaryScore,
          diaryEmotion: data.data!.diaryEmotion,
          diaryMet: data.data!.diaryMet,
        ));
        print("데이터 저장했다 $diaryDetailData");
      }
    } catch (e) {
      print(e);
    }
  }

  deleteDiary(var id) async {
    try {
      var data = await DiaryServices().deleteDiary(id);
      if (data.state == 200) {
        Get.snackbar("삭제", "해당 일기 삭제 완료하였습니다.");
        print(diaryDetailData.value.userId.runtimeType);
        Get.offNamed("/dashboard");
      }
    } catch (e) {
      print(e);
    }
  }
}
