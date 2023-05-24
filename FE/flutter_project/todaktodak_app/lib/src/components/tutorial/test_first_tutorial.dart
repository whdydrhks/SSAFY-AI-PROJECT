import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:test_app/src/components/diary/modify/stt_component.dart';
import 'package:test_app/src/config/palette.dart';

class TestFirstTutorial extends StatefulWidget {
  TestFirstTutorial({Key? key}) : super(key: key);
  int step = 1;
  String tutorialText = '안녕하세요! \n제가 일기를 쓰는 방법을 알려드릴게요!';

  @override
  State<TestFirstTutorial> createState() => _TestFirstTutorialState();
}

class _TestFirstTutorialState extends State<TestFirstTutorial> {
  @override
  Widget build(BuildContext context) {
    if (widget.step == 2) {
      widget.tutorialText = '이곳에서 문장 단위로 일기를 작성하며 토닥이와 소통할 수 있어요!';
    }

    return Stack(
      children: [
        Positioned(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              // backgroundBlendMode: BlendMode.values[12],
            ),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  'test',
                  style: TextStyle(
                    fontSize: 18,
                    color: Palette.blackTextColor,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
