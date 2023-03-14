import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/pages/register/register_page.dart';
import 'package:test_app/src/pages/register/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '토닥토닥',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.pink,
          scaffoldBackgroundColor: const Color(0xffFFE7E7),
          fontFamily: "Jua_Regular"),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const SplashPage()),
        GetPage(name: "/register", page: () => const RegisterPage()),
      ],
    );
  }
}
