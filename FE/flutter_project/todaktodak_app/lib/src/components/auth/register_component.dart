import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth/register_controller.dart';

class RegisterComponent extends StatelessWidget {
  RegisterComponent({super.key});
  final _controller = Get.find<RegisterController>();
  Widget _explain() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: const Text(
          "저희 서비스는 일기를 토대로 감정을 상담해주면서 분석을 해주는 서비스입니다. 저희 서비스를 이용하기 위해서 고객님의 소중한 모바일 기기의 정보를 제공해주셔야 이용이 가능합니다. ",
          maxLines: 5,
        ));
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RegisterController());
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      width: 240,
                                      child: TextFormField(
                                        controller:
                                            _controller.nicknameController,
                                        onChanged: (value) {
                                          _controller.onChangeNickname(value);
                                        },
                                        validator: (value) {
                                          return _controller
                                              .onNicknameLength(value!);
                                        },
                                        decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.person),
                                            labelText: "닉네임"),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                                value: Get.find<RegisterController>()
                                    .ischecked
                                    .value,
                                activeColor: const Color(0xff0f1648a),
                                onChanged: (value) {
                                  _controller.changeCheck(value);
                                }),
                            const Text("기기고유정보 사용에 동의합니다."),
                            IconButton(
                                onPressed: () {
                                  Get.find<RegisterController>().test();
                                },
                                icon: Icon(_controller.isAgree == false
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down))
                          ],
                        ),
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
                          style: TextStyle(fontSize: 24),
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
  }
}
