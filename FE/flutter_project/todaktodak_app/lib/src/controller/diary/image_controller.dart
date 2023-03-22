import 'package:get/get.dart';
import 'package:test_app/src/model/diary/selected_image.dart';

class ImageController extends GetxController {
  final RxList images = <SelectedImage>[
    SelectedImage(imagePath: 'assets/images/happy.png'),
    SelectedImage(imagePath: 'assets/images/sad.png'),
    SelectedImage(imagePath: 'assets/images/embarr.png'),
    SelectedImage(imagePath: 'assets/images/angry.png'),
    SelectedImage(imagePath: 'assets/images/nomal.png'),
  ].obs;

  void toggleImage(SelectedImage image) {
    // 이미지 선택 토글
    image.isSelected = !image.isSelected!;
  }
}
