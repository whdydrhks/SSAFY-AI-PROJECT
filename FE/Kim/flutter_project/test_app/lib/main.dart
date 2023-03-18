import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/register_controller.dart';
import 'package:test_app/src/pages/calendar/calendar_page.dart';
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
          primaryColor: const Color(0xffF1648A),
          scaffoldBackgroundColor: const Color(0xffF2F2F2),
          fontFamily: "Jua_Regular"),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const SplashPage()),
        GetPage(
            name: "/register",
            page: () => RegisterPage(),
            binding: BindingsBuilder(() {
              Get.put(RegisterController());
            })),
        GetPage(name: "/calendar", page: () => CalendarPage())
      ],
    );
  }
}
