import 'package:flutter/material.dart';
import 'package:test_app/src/config/palette.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            width: 140,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextButton(
              onPressed: () {},
              child: Text(
                '월간',
                style: TextStyle(
                  color: Palette.blackTextColor,
                  fontSize: 16,
                ),
              ),
              style: ButtonStyle(
                // backgroundColor: MaterialStatePropertyAll(Palette.pinkColor),
                backgroundColor: MaterialStatePropertyAll(Colors.white),
              ),
            ),
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            width: 140,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextButton(
              onPressed: () {},
              child: Text(
                '연간',
                style: TextStyle(
                  color: Palette.blackTextColor,
                  fontSize: 16,
                ),
              ),
              style: ButtonStyle(
                // backgroundColor: MaterialStatePropertyAll(Palette.pinkColor),
                backgroundColor: MaterialStatePropertyAll(Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
