import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:test_app/src/binding/Init_binding.dart';
import 'package:test_app/src/controller/app_controller.dart';
import 'package:test_app/src/controller/auth/register_controller.dart';
import 'package:test_app/src/controller/calendar/calendar_controller.dart';
import 'package:test_app/src/controller/dashboard/dashboard_controller.dart';
import 'package:test_app/src/controller/diary/diary_datail_controller.dart';
import 'package:test_app/src/controller/diary/diary_modify_controller.dart';
import 'package:test_app/src/controller/diary/diary_write_controller.dart';
import 'package:test_app/src/controller/setting/setting_controller.dart';
import 'package:test_app/src/pages/analysis/analysis_page.dart';
import 'package:test_app/src/pages/app.dart';
import 'package:test_app/src/pages/calendar/calendar_page.dart';
import 'package:test_app/src/pages/dashboard/dashboard_page.dart';
import 'package:test_app/src/pages/diary/diary_detail_page.dart';
import 'package:test_app/src/pages/diary/diary_modify_page.dart';
import 'package:test_app/src/pages/diary/diary_page.dart';
import 'package:test_app/src/pages/diary/diary_write_page.dart';
import 'package:test_app/src/pages/auth/register_page.dart';
import 'package:test_app/src/pages/auth/splash_page.dart';
import 'package:test_app/src/pages/setting/setting_backup_page.dart';
import 'package:test_app/src/pages/setting/setting_page.dart';
import 'package:test_app/src/pages/setting/setting_theme_page.dart';

void main() async {
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return GetMaterialApp(
            title: '토닥토닥',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: const Color(0xffF1648A),
              scaffoldBackgroundColor: const Color(0xffF2F2F2),
              fontFamily: "Jua_Regular",
            ),
            initialRoute: "/",
            // initialBinding: InitBinding(),
            getPages: [
              GetPage(name: "/", page: () => SplashPage()),
              GetPage(
                  name: "/app",
                  page: () => const App(),
                  binding: BindingsBuilder(() {
                    Get.put(AppController());
                  })),
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
                  page: () => const CalendarPage(),
                  binding: BindingsBuilder(() {
                    Get.put(CalendarController());
                  })),
              GetPage(
                  name: "/write",
                  transition: Transition.rightToLeft,
                  page: () => const DiaryWritePage(),
                  binding: BindingsBuilder(() {
                    Get.lazyPut(() => DiaryWriteController());
                  })),
              GetPage(
                  name: "/diary",
                  transition: Transition.rightToLeft,
                  page: () => const DiaryPage(),
                  binding: BindingsBuilder(() {
                    Get.put(DiaryWriteController());
                  })),
              GetPage(
                  name: "/analysis",
                  transition: Transition.rightToLeft,
                  page: () => AnalysisPage(),
                  binding: BindingsBuilder(() {
                    Get.put(DiaryWriteController());
                  })),

              //일기 디테일 테스트 페이지
              GetPage(
                  name: "/detail/:diaryId",
                  page: () => const DiaryDetailPage(),
                  binding: BindingsBuilder(() {
                    Get.put(DiaryDetailController());
                  })),
              GetPage(
                  name: "/modify/:id",
                  page: () => DiaryModifyPage(),
                  binding: BindingsBuilder(() {
                    Get.put(ModifyController());
                  })),
              GetPage(
                name: "/theme",
                page: () => SettingThemePage(),
              ),
              GetPage(
                name: "/backup",
                page: () => SettingBackupPage(),
              ),
            ],
            // builder: (context, child) {
            //   return Theme(
            //       data: currentMode == ThemeMode.dark
            //           ? ThemeData.dark()
            //           : ThemeData.light(),
            //       child: child!);
            // },
          );
        });
  }
}
