import 'package:flutter/material.dart';

class EmotionComponent extends StatelessWidget {
  EmotionComponent({super.key});
  final imageList = [
    "assets/images/happy.png",
    "assets/images/upset.png",
    "assets/images/sad.png",
    "assets/images/angry.png",
    "assets/images/depressed.png",
  ];
  _box() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 0.5,
            color: Color(0x35531F13),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 360,
        height: 176,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: _box(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "감정",
              style: TextStyle(fontSize: 24),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 60,
                    height: 60,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Image.asset(imageList[index]),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 16,
            )
          ],
        ));
  }
}
