import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:test_app/src/config/palette.dart';

class FirstTutorial extends StatelessWidget {
  const FirstTutorial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.4),
      child: Stack(
        children: [
          Positioned(bottom: 0, left: 0, child: Image.asset('assets/images/loading_rabbit.PNG', width: 90,)),
          Positioned(bottom: 20, left: 100, child: Bubble(
            nip: BubbleNip.leftTop,
            color: Colors.white,
            child: Container(width: 250, height: 100, child: Text('안녕하세요! \n오늘은 어떤 일이 있었나요?',
            style: TextStyle(fontSize: 20, color: Palette.blackTextColor,),
            ),),
          ),),
        ],
      ),
    );
  }
}
