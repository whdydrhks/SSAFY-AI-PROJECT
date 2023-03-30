import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/components/diary/detail/diary_detail_emotion_count_component.dart';
import 'package:test_app/src/components/diary/detail/diary_detail_icon_component.dart';
import 'package:test_app/src/components/diary/detail/diray_detail_appbar.dart';
import 'package:test_app/src/config/mode.dart';
import 'package:test_app/src/controller/diary/diary_datail_controller.dart';
import '../../components/diary/detail/diary_detail_diarycontents_component.dart';

class DiaryDetailPage extends StatefulWidget {
  const DiaryDetailPage({Key? key}) : super(key: key);

  @override
  State<DiaryDetailPage> createState() => _DiaryDetailPageState();
}

class _DiaryDetailPageState extends State<DiaryDetailPage> {
  final _controller = Get.put(DiaryDetailController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: MyApp.themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "123",
              style: TextStyle(
                color: Mode.textMode(currentMode),
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.keyboard_arrow_left),
            ),
            iconTheme: IconThemeData(color: Mode.textMode(currentMode)),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: const [DiaryDetailAppbar()],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: FutureBuilder(
              future: _controller.getDiaryDetail(Get.parameters["diaryId"]),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error"));
                } else {
                  return ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      const DiaryDetailIconComponent(),
                      const SizedBox(
                        height: 16,
                      ),
                      DiaryDetailDiaryContentsComponent(),
                      const SizedBox(
                        height: 16,
                      ),
                      const DiaryDetailEmotionCountComponent(),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
