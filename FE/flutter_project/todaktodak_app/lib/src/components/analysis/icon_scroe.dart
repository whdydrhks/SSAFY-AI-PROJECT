import 'package:flutter/material.dart';
import 'package:test_app/src/config/palette.dart';

class IconScore extends StatefulWidget {
  final top5Count;
  final top5Map;
  final emptyCount;

  const IconScore({Key? key, this.top5Count, this.top5Map, this.emptyCount})
      : super(key: key);

  @override
  State<IconScore> createState() => _IconScoreState();
}

class _IconScoreState extends State<IconScore> {
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
              for (int i = 0; i < widget.top5Count; i++)
                Column(
                  children: [
                    iconScoreListCard(
                        i + 1,
                        'assets/images/top_five/${widget.top5Map.keys.elementAt(i)}.png',
                        '${widget.top5Map.keys.elementAt(i)}',
                        widget.top5Map.values.elementAt(i),
                        'emotion'),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              for (int i = 0; i < widget.emptyCount; i++)
                Column(
                  children: [
                    emptyIconScoreListCard(),
                    const SizedBox(
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
              imagePath,
              width: type == 'emotion' ? 40 : 40,
            ),
          ],
        ),
        Text(
          iconTitle,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        Text(
          '$iconCount',
          style: const TextStyle(
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
