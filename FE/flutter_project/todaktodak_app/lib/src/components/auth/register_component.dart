import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';
import 'package:test_app/src/config/palette.dart';

import '../../controller/auth/register_controller.dart';

class RegisterComponent extends StatelessWidget {
  RegisterComponent({super.key});
  final _controller = Get.find<RegisterController>();
  Widget _explain() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Expanded(
          flex: 2,
          child: Text(
            "저희 서비스는 일기를 토대로 감정을 상담해주면서 분석을 해주는 서비스입니다. 저희 서비스를 이용하기 위해서 고객님의 소중한 모바일 기기의 정보를 제공해주셔야 이용이 가능합니다. ",
            style: TextStyle(fontFamily: 'Jua_Regular', fontSize: 16),
            maxLines: 6,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RegisterController());
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return Obx(() => Scaffold(
                body: Form(
                  key: _controller.registerFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Padding(
                    padding: const EdgeInsets.all(23),
                    child: Column(
                      children: [
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.height,
                                height: 240,
                                decoration: BoxDecoration(
                                    color: Mode.boxMode(currentMode),
                                    borderRadius: BorderRadius.circular(16)),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: TextFormField(
                                              style: const TextStyle(
                                                  fontFamily: 'Jua_Regular',
                                                  fontSize: 18),
                                              controller: _controller
                                                  .nicknameController,
                                              onChanged: (value) {
                                                _controller
                                                    .onChangeNickname(value);
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "닉네임을 입력해주세요";
                                                } else if (_controller
                                                        .isvalidate.value ==
                                                    true) {
                                                  return "이미 존재하는 닉네임 입니다.";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                prefixIcon:
                                                    const Icon(Icons.person),
                                                labelText: "닉네임",
                                                errorText: _controller
                                                            .isvalidate.value ==
                                                        true
                                                    ? "이미 존재하는 닉네임 입니다."
                                                    : null,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                        ],
                                      )
                                    ]),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 12,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Checkbox(
                                            value:
                                                Get.find<RegisterController>()
                                                    .ischecked
                                                    .value,
                                            activeColor:
                                                const Color(0xff0f1648a),
                                            onChanged: (value) {
                                              _controller.changeCheck(value);
                                            }),
                                      ),
                                      const Expanded(
                                        flex: 10,
                                        child: Center(
                                          child: Text(
                                            "기기고유정보 사용에 동의합니다.",
                                            style: TextStyle(
                                                fontFamily: 'Jua_Regular',
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Get.find<RegisterController>()
                                                .test();
                                          },
                                          icon: Icon(
                                              _controller.isAgree == false
                                                  ? Icons.keyboard_arrow_down
                                                  : Icons.keyboard_arrow_up))
                                    ],
                                  )),
                              if (_controller.isAgree == true) ...[
                                _explain(),
                              ]
                            ],
                          ),
                        )),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  backgroundColor: const Color(0xffF1648A)),
                              child: const Text(
                                "회원가입",
                                style: TextStyle(
                                    fontSize: 24, fontFamily: 'Jua_Regular'),
                              ),
                              onPressed: () {
                                Get.find<RegisterController>().register();
                                // Get.offNamed("/dashboard");
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
