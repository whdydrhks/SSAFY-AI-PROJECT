import 'package:flutter/material.dart';

class SttComponent extends StatelessWidget {
  const SttComponent({super.key});
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
    return Container(
      width: 360,
      height: 42,
      decoration: _box(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 8),
            child: Text("안녕하십니까"),
          ),
          GestureDetector(
            onTap: () {
              print("stt사용하자");
            },
            child: Container(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.mic_none)),
          )
        ],
      ),
    );
  }
}
