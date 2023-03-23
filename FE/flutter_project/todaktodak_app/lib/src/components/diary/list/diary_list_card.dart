import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryListCard extends StatelessWidget {
  const DiaryListCard({
    super.key,
    required this.diary,
  });

  final diary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed('/detail/${diary.id}');
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.transparent,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width - 32,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 8,
                ),
                Image.asset(
                  'assets/images/score/${diary.rating}.png',
                  width: 60,
                ),
                Text(
                  '${diary.date.substring(0, 10)} ${diary.day}',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
