import 'package:flutter/material.dart';

class ExPlain extends StatefulWidget {
  const ExPlain({super.key});

  @override
  State<ExPlain> createState() => _ExPlainState();
}

class _ExPlainState extends State<ExPlain> {
  List<bool> registerList = [false, false];
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
        onPressed: (index) {
          print(registerList[index]);
        },
        isSelected: registerList,
        children: [Text("회원가입"), Text("불러오기")]);
  }
}
