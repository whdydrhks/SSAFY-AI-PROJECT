import 'package:flutter/material.dart';
import 'package:test_app/src/components/analysis/test_three_top_nav.dart';
import 'package:test_app/src/config/palette.dart';

class NewIconScores extends StatefulWidget {
  final top5Count;
  final newTop5Map;
  final emptyCount;
  final selectedIconRankingTabIndex;
  final selectedTop5Map;

  const NewIconScores(
      {Key? key,
      this.top5Count,
      this.newTop5Map,
      this.emptyCount,
      this.selectedIconRankingTabIndex,
      this.selectedTop5Map})
      : super(key: key);

  @override
  State<NewIconScores> createState() => _NewIconScoresState();
}

class _NewIconScoresState extends State<NewIconScores> {
  var feelList = ['기쁨', '슬픔', '분노', '피곤', '불안'];

  @override
  void initState() {
    super.initState();
  }

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
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            TestThreeTabBar(),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 16),
              child: Column(
                children: [
                  for (int i = 0; i < widget.top5Count; i++)
                    Column(
                      children: [
                        iconScoreListCard(i),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget iconScoreListCard(int i) {
    try {
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
                      '${i + 1}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Palette.blackTextColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Image.asset(
                'assets/images/top_five/${widget.newTop5Map.keys.elementAt(i)}.png',
                width: 40,
              ),
            ],
          ),
          Text(
            '${widget.newTop5Map.keys.elementAt(i)}',
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          Text(
            '${widget.newTop5Map.values.elementAt(i)}',
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      );
    } catch (e) {
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
              const SizedBox(
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
          const Text(
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
            const SizedBox(
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
        const Text(
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
