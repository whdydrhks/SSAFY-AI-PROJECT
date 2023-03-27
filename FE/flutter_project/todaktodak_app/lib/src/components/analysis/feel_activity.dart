import 'package:flutter/material.dart';

import '../../config/palette.dart';

class FeelActivity extends StatefulWidget {
  final controller;

  const FeelActivity({Key? key, this.controller}) : super(key: key);

  @override
  State<FeelActivity> createState() => _FeelActivityState();
}

class _FeelActivityState extends State<FeelActivity> {
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
              Padding(
                padding: const EdgeInsets.only(left: 36, right: 36),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 5; i > 0; i--)
                      GestureDetector(
                        onTap: () {
                          widget.controller.changeSelectedFeel(i);
                          setState(() {});
                        },
                        child: Image.asset(
                          i == widget.controller.selectedFeel.value
                              ? 'assets/images/score/$i.png'
                              : 'assets/images/score/${i}_b.png',
                          width: 43,
                        ),
                      ),
                  ],
                ),
              ),
              Row(
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
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: (MediaQuery.of(context).size.width - 96) * 0.5,
                    child: Column(
                      children: [
                        for (int i = 5; i < 10; i++) listCard(i),
                      ],
                    ),
                  ),
                ],
              ),
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
                        style: TextStyle(
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
                    'assets/images/top_five/${widget.controller.feelActivityMap.value[widget.controller.selectedFeel]!.keys.elementAt(i)}.png',
                    width: 30,
                  ),
                ),
                Center(
                  child: Text(
                    '${widget.controller.feelActivityMap.value[widget.controller.selectedFeel]!.keys.elementAt(i)}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
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
                        style: TextStyle(
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
          SizedBox(
            height: 16,
          ),
        ],
      );
    }
  }
}
