import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';

import '../../controller/auth/splash_controller.dart';

class SplashPage extends StatelessWidget {
  final controller = Get.put(SplashController());
  SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<ThemeMode>(
        valueListenable:  MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset('assets/images/happy.png'),
              const SizedBox(
                height: 24,
              ),
              Text(
                "토닥토닥",
                style: TextStyle(fontSize: 48, fontFamily: 'Jua_Regular', color: Mode.textMode(currentMode)),
              ),
              const SizedBox(
                height: 24,
              ),
              const SpinKitRing(
                color: Color(0xff212529),
                size: 50.0,
              )
            ]),
          );
        }
      ),
    );
  }
}
