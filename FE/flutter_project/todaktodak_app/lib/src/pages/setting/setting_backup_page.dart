import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/setting/setting_backup_controller.dart';

class SettingBackupPage extends StatelessWidget {
  const SettingBackupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingBackupController());
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
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: TextFormField(
                              controller:
                                  SettingBackupController.to.passWordController,
                              onChanged: (value) => {
                                SettingBackupController.to
                                    .onChangePassword(value)
                              },
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "비밀번호를 입력해주세요";
                                } else {
                                  return null;
                                }
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: '비밀번호를 등록해주세요',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: Colors.blueGrey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: Color(0xffF1648A)))),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: TextField(
                              controller: SettingBackupController
                                  .to.passWordConfirmController,
                              onChanged: (value) => {
                                SettingBackupController.to
                                    .onChangePasswordConfirm(value)
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: '비밀번호를 다시 입력해주세요',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: Colors.blueGrey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: Color(0xffF1648A)))),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  backgroundColor: const Color(0xffF1648A),
                                ),
                                onPressed: () {
                                  SettingBackupController.to.requestBackup();
                                },
                                child: const Text(
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
