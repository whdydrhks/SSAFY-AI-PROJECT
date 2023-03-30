import 'package:flutter/material.dart';

class Message {
  static Text title(String title) {
    return Text(
      "$title",
      style: TextStyle(fontFamily: 'Jua_Regular', fontSize: 16),
    );
  }

  static Text message(String message) {
    return Text(
      "$message",
      style: TextStyle(fontFamily: 'Jua_Regular', fontSize: 16),
    );
  }
}
