import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/config/palette.dart';

class IconScore extends StatelessWidget {
  final controller;

  const IconScore({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, top: 16),
          child: Column(
            children: [
              for (int i = 0; i < controller.top5Count.value; i++)
                Column(
                  children: [
                    iconScoreListCard(
                        i + 1,
                        'assets/images/top_five/${controller.top5Map.keys.elementAt(i)}.png',
                        '${controller.top5Map.keys.elementAt(i)}',
                        controller.top5Map.values.elementAt(i),
                        'emotion'),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              for (int i = 0; i < controller.emptyCount.value; i++)
                Column(
                  children: [
                    emptyIconScoreListCard(),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Row iconScoreListCard(int score, String imagePath, String iconTitle,
      int iconCount, String type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(1, 3),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  child: Text(
                    '$score',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Palette.blackTextColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Image.asset(
              imagePath,
              width: type == 'emotion' ? 40 : 40,
            ),
          ],
        ),
        Text(
          iconTitle,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        Text(
          '$iconCount',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ],
    );
  }

  Row emptyIconScoreListCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(1, 3),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  child: Text(
                    '-',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Icon(Icons.remove_circle_outline_rounded,
                size: 40, color: Colors.grey.withOpacity(0.6))
          ],
        ),
        Text(
          '기록 없음',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey.withOpacity(0.6),
          ),
        ),
        Text(
          '- ',
          style: TextStyle(
            fontSize: 24,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
