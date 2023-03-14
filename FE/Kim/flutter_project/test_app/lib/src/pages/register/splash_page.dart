import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    setState(() {
      _timer = Timer.periodic(const Duration(microseconds: 1), (timer) {
        print(timer.tick);
        if (timer.tick == 3000) {
          Get.offNamed("/register");
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/images/happy.png'),
          const Text(
            "토닥토닥",
            style: TextStyle(fontSize: 32),
          ),
          const SizedBox(
            height: 24,
          ),
          const SpinKitRing(
            color: Color(0xffffffff),
            size: 50.0,
          )
        ]),
      ),
    );
  }
}
