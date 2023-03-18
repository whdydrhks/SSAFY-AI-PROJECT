import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final storage = FlutterSecureStorage();
  getUserInfo() async {
    final userId = await storage.read(key: "id");
    final userPw = await storage.read(key: "pass");
    print("$userId $userPw");
  }

  @override
  void initState() {
    // TODO: implement initState
    print("스토리지 값 얻어와");
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("캘린더페이지입니다."),
      ),
    );
  }
}
