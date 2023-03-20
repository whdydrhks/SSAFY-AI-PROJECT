import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/auth/register_controller.dart';
import 'package:test_app/src/controller/calendar/calendar_controller.dart';
import 'package:test_app/src/controller/dashboard/dashboard_controller.dart';
import 'package:test_app/src/controller/diary/diary_write_controller.dart';
import 'package:test_app/src/pages/calendar/calendar_page.dart';
import 'package:test_app/src/pages/dashboard/dashboard_page.dart';
import 'package:test_app/src/pages/diary/diary_write_page.dart';
import 'package:test_app/src/pages/auth/register_page.dart';
import 'package:test_app/src/pages/auth/splash_page.dart';

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
            page: () => const RegisterPage(),
            binding: BindingsBuilder(() {
              Get.put(RegisterController());
            })),
        GetPage(
            name: "/dashboard",
            page: () => const DashBoardPage(),
            binding: BindingsBuilder(() {
              Get.put(DashBoardController());
            })),
        GetPage(
            name: "/calendar",
            page: () => CalendarPage(),
            binding: BindingsBuilder(() {
              Get.put(CalendarController());
            })),
        GetPage(
            name: "/write",
            transition: Transition.rightToLeft,
            page: () => DiaryWritePage(),
            binding: BindingsBuilder(() {
              Get.put(DiaryWriteController());
            }))
      ],
    );
  }
}
