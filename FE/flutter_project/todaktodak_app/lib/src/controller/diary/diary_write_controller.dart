import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/calendar/calendar_controller.dart';
import 'package:test_app/src/model/diary/selected_image.dart';

class DiaryWriteController extends GetxController {
  late CalendarController calendar;

  final storage = const FlutterSecureStorage();
  var test = 0.obs;
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
      print('$key $value');
    });
    super.onInit();
  }

  void togglePeopleImage(int index) {
    // print(index);
    print(peopleImages[index]);
    peopleImages[index].isSelected = !peopleImages[index].isSelected!;
  }

  void toggleImage(SelectedImage image) {
    // 이미지 선택 토글
    print(image);
    image.isSelected = !image.isSelected!;
  }

  void testChangeGradePoint(int index) {
    test.value = index;
    isSelected(!false);
  }

  void colorChangeIndex(int index) {}
  @override
  void dispose() {
    calendar.dispose();
    super.dispose();
  }
}
