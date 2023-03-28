import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/palette.dart';

class SettingBackupPage extends StatelessWidget {
  const SettingBackupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ValueListenableBuilder<ThemeMode>(
          valueListenable: MyApp.themeNotifier,
          builder: (_, ThemeMode currentMode, __) {
            return Scaffold(
              appBar: AppBar(
                title: Text("백업",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Jua_Regular',
                        color: currentMode == ThemeMode.dark
                            ? Colors.white
                            : Palette.blackTextColor)),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    color: currentMode == ThemeMode.dark
                        ? Colors.white
                        : Palette.blackTextColor,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 12),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: '비밀번호를 등록해주세요',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide:
                                          BorderSide(color: Colors.blueGrey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                          color: Color(0xffF1648A)))),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: '비밀번호를 다시 입력해주세요',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide:
                                          BorderSide(color: Colors.blueGrey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                          color: Color(0xffF1648A)))),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  backgroundColor: Color(0xffF1648A),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "백업",
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: 'Jua_Regular'),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
