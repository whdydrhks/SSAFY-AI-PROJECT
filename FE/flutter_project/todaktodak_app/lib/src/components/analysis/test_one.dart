import 'package:flutter/material.dart';

import '../../config/palette.dart';

class TestOne extends StatefulWidget {
  final feelActivityMap;
  final changeSelectedFeel;
  final selectedFeel;

  const TestOne(
      {Key? key,
      this.feelActivityMap,
      this.changeSelectedFeel,
      this.selectedFeel})
      : super(key: key);

  @override
  State<TestOne> createState() => _TestOneState();
}

class _TestOneState extends State<TestOne> {
  var feelList = [
    'assets/images/top_five/기쁨.png',
    'assets/images/top_five/분노.png',
    'assets/images/top_five/불안.png',
    'assets/images/top_five/슬픔.png',
    'assets/images/top_five/피곤.png',
  ];

  var feelNames = ['기쁨', '분노', '불안', '슬픔', '피곤'];

  var relationList = [
    'assets/images/top_five/연인.png',
    'assets/images/top_five/가족.png',
    'assets/images/top_five/지인.png',
    'assets/images/top_five/친구.png',
    'assets/images/top_five/혼자.png',
  ];

  var relationNames = ['연인', '가족', '지인', '친구', '혼자'];

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
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 52),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '감정',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '관계',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      width: (MediaQuery.of(context).size.width - 96) * 0.5,
                      child: Column(
                        children: [
                          for (int i = 0; i < 5; i++) listCard(i),
                        ],
                      ),
                    ),

                    // 수직 구분선
                    // Container(
                    //   margin: const EdgeInsets.only(top: 16),
                    //   width: 1,
                    //   height: 300,
                    //   color: Colors.grey.withOpacity(0.6),
                    // ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      width: (MediaQuery.of(context).size.width - 96) * 0.5,
                      child: Column(
                        children: [
                          for (int i = 0; i < 5; i++) activityListCard(i),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget listCard(int i) {
    try {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 45,
                  height: 45,
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
                        '${i + 1}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Palette.blackTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    feelList[i],
                    width: 30,
                  ),
                ),
                Center(
                  child: Text(
                    '${feelNames[i]}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      );
    } catch (e) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 45,
                  height: 45,
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
                        '${i + 1}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Palette.blackTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                    child: Icon(Icons.remove_circle_outline_rounded,
                        size: 40, color: Colors.grey.withOpacity(0.6))),
                Center(
                  child: Text(
                    '없음',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      );
    }
  }

  Widget activityListCard(int i) {
    try {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 45,
                  height: 45,
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
                        '${i + 1}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Palette.blackTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    relationList[i],
                    width: 30,
                  ),
                ),
                Center(
                  child: Text(
                    '${relationNames[i]}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      );
    } catch (e) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 45,
                  height: 45,
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
                        '${i + 1}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Palette.blackTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                    child: Icon(Icons.remove_circle_outline_rounded,
                        size: 40, color: Colors.grey.withOpacity(0.6))),
                Center(
                  child: Text(
                    '없음',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      );
    }
  }
}
