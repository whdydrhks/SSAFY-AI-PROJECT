import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:test_app/src/components/diary/modify/stt_component.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/app_controller.dart';
import 'package:get/get.dart';

class FirstTutorial extends StatefulWidget {
  FirstTutorial({Key? key}) : super(key: key);
  int step = 1;
  String tutorialText = '안녕하세요! \n제가 일기를 쓰는 방법을 알려드릴게요!';

  @override
  State<FirstTutorial> createState() => _FirstTutorialState();

  final appController = Get.put(AppController());

  bool isShow() {
    return appController.isShowTutorial && appController.isSignUpUser;
  }
}

class _FirstTutorialState extends State<FirstTutorial> {
  @override
  void dispose() {
    super.dispose();
    widget.appController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.step == 2) {
      widget.tutorialText = '이곳은 여러분들이 일기를 작성하며,\n토닥이와 소통할 수 있는 공간입니다!';
    } else if (widget.step == 3) {
      widget.tutorialText =
          '토닥이가 대화를 기다리고 있습니다.\n여러분의 이야기를 경청하고,\n따뜻한 답변을 드릴거에요!';
    } else if (widget.step == 4) {
      widget.tutorialText =
          '작성된 일기는 이곳에 기록됩니다.\n자유롭게 일기를 작성하고\n토닥이와 대화를 즐겨보세요!';
    } else if (widget.step == 5) {
      widget.appController.isShowTutorial = false;
    }

    return widget.isShow()
        ? Stack(
            children: [
              Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black.withOpacity(0.4),
                  child: Stack(
                    children: [
                      Positioned(
                          bottom: 0,
                          left: 0,
                          child: Image.asset(
                            'assets/images/diary/3dRabbit.png',
                            width: 90,
                          )),
                      Positioned(
                        bottom: 10,
                        left: 100,
                        child: Bubble(
                          nip: BubbleNip.leftTop,
                          color: Colors.white,
                          padding: const BubbleEdges.only(
                              left: 16, right: 16, top: 16, bottom: 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.64,
                            height: 110,
                            child: Stack(children: [
                              Text(
                                widget.tutorialText,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Palette.blackTextColor,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Palette.pinkColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      widget.step += 1;
                                    });
                                  },
                                  child: Text(
                                    widget.step == 4 ? '확인' : '다음',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.step == 2)
                Positioned(
                  top: 155,
                  left: 8,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 16,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Palette.pinkColor,
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              if (widget.step == 3)
                Positioned(
                  top: 72,
                  left: 8,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 16,
                    height: 85,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Palette.pinkColor,
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              if (widget.step == 4)
                Positioned(
                  top: 230,
                  left: 8,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 16,
                    height: 195,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Palette.pinkColor,
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
            ],
          )
        : Container();
    // return Container();
  }
}
