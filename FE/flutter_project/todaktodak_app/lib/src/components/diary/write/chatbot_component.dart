import 'package:flutter/material.dart';

class ChatBotComponent extends StatelessWidget {
  const ChatBotComponent({super.key});
  _box() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 0.5,
            color: Color(0x35531F13),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 84,
            height: 84,
            child: Image.asset("assets/images/happy.png")),
        SizedBox(
          width: 8,
        ),
        Container(
          width: 278,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: _box(),
          child: Text("오 행복해보이시네요"),
        )
      ],
    );
  }
}
