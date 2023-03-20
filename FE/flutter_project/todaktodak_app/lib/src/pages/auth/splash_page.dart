import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../controller/auth/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controller = SplashController();
  @override
  void initState() {
    super.initState();
    controller.loading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/images/happy.png'),
          const SizedBox(
            height: 24,
          ),
          const Text(
            "토닥토닥",
            style: TextStyle(fontSize: 48),
          ),
          const SizedBox(
            height: 24,
          ),
          const SpinKitRing(
            color: Color(0xff212529),
            size: 50.0,
          )
        ]),
      ),
    );
  }
}
