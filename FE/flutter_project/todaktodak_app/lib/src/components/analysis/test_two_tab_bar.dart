import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestTwoDropDown extends StatelessWidget {
  final controller;

  const TestTwoDropDown({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: PopupMenuButton(
        padding: EdgeInsets.all(0),
        offset: Offset(0, 40),
        shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          0,
        ),
        elevation: 5,
        itemBuilder: (context) {
          return <PopupMenuEntry>[
            PopupMenuItem(
              child: Center(
                child: Text(
                  '전체',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              value: 'feel',
            ),
            PopupMenuItem(
              height: 1,
              child: Divider(
                height: 1,
                color: Colors.black,
              ),
              enabled: false,
            ),
            PopupMenuItem(
              child: Center(
                child: Text(
                  '감정',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              value: 'relation',
            ),
            PopupMenuItem(
              height: 1,
              child: Divider(
                height: 1,
                color: Colors.black,
              ),
              enabled: false,
            ),
            PopupMenuItem(
              child: Center(
                child: Text(
                  '관계',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              value: 'relation',
            ),
          ];
        },
        child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Text(
                  '전체',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                ),
              ],
            )),
        onSelected: (value) {},
      ),
    );
  }
}
