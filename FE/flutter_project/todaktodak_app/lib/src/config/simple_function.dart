import 'package:flutter/material.dart';

class SimpleFunction {
  Widget chooseImage(int rating, double imageSize) {
    switch (rating) {
      case 1:
        return Image.asset(
          'assets/images/happy.png',
          width: imageSize,
        );
      case 2:
        return Image.asset(
          'assets/images/sad.png',
          width: imageSize,
        );
      case 3:
        return Image.asset(
          'assets/images/angry.png',
          width: imageSize,
        );
      default:
        return Container();
    }
  }
}
