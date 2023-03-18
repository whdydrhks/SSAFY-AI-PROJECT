import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/register_controller.dart';

class RegisterComponent extends StatelessWidget {
  const RegisterComponent({super.key});

  Widget _explain() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          "저희 서비스는 일기를 토대로 감정을 상담해주면서 분석을 해주는 서비스입니다. 저희 서비스를 이용하기 위해서 고객님의 소중한 모바일 기기의 정보를 제공해주셔야 이용이 가능합니다. ",
          maxLines: 5,
        ));
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RegisterController());
    return Obx(() => Scaffold(
          body: Form(
            key: Get.find<RegisterController>().registerFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: EdgeInsets.all(23),
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller:
                                            Get.find<RegisterController>()
                                                .nicknameController,
                                        onChanged: (value) {
                                          Get.find<RegisterController>()
                                              .onChangeNickname(value);
                                        },
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.person),
                                            labelText: "닉네임"),
                                      ),
                                      width: 240,
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                  ],
                                )
                              ]),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                                value: Get.find<RegisterController>()
                                    .ischecked
                                    .value,
                                activeColor: Color(0xff0F1648A),
                                onChanged: (value) {
                                  Get.find<RegisterController>()
                                      .changeCheck(value);
                                }),
                            Text("기기고유정보 사용에 동의합니다."),
                            IconButton(
                                onPressed: () {
                                  Get.find<RegisterController>().test();
                                },
                                icon: Icon(
                                    Get.find<RegisterController>().isAgree ==
                                            false
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down))
                          ],
                        ),
                        if (Get.find<RegisterController>().isAgree == true) ...[
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
                            backgroundColor: Color(0xffF1648A)),
                        child: Text(
                          "회원가입",
                          style: TextStyle(fontSize: 24),
                        ),
                        onPressed: () {
                          Get.find<RegisterController>().register();
                          Get.offNamed("/calendar");
                        }),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
