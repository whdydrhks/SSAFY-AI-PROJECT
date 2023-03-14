import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _ischecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              decoration: const BoxDecoration(
                  color: Colors.black, shape: BoxShape.circle),
              child: const CircleAvatar(
                radius: 48,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("assets/images/happy.png"),
              ),
            ),
            const Text(
              "안녕하세요, 고객님\n토닥토닥입니다.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Checkbox(
              value: _ischecked,
              activeColor: const Color(0xffFFCDCD),
              onChanged: (bool? value) {
                setState(() {
                  _ischecked = value!;
                });
              },
            ),
            GestureDetector(
              onTap: () {
                print("펼쳐라");
              },
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("기기고유정보 사용에 동의합니다."),
                  Icon(Icons.keyboard_arrow_up)
                ],
              ),
            )
          ],
        ),
        ElevatedButton(
            onPressed: () {
              print("눌렀습니다.");
            },
            child: const Text("시작하기"))
      ],
    ));
  }
}
