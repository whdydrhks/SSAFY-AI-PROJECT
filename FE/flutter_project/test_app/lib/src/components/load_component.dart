import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/controller/load_controller.dart';

class LoadComponent extends StatelessWidget {
  const LoadComponent({super.key});

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
    Get.put(LoadController());
    return Obx(() => Scaffold(
          body: Padding(
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
                                      onChanged: (value) {
                                        Get.find<LoadController>()
                                            .changeNickname(value);
                                      },
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.person),
                                          labelText: "닉네임"),
                                    ),
                                    width: 240,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        Get.find<LoadController>()
                                            .changeNickname(value);
                                      },
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.lock),
                                          labelText: "비밀번호"),
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
                              value: Get.find<LoadController>().ischecked.value,
                              activeColor: Color(0xff0F1648A),
                              onChanged: (value) {
                                Get.find<LoadController>().changeCheck(value);
                              }),
                          Text("기기고유정보 사용에 동의합니다."),
                          IconButton(
                              onPressed: () {
                                Get.find<LoadController>().test();
                              },
                              icon: Icon(
                                  Get.find<LoadController>().isAgree == false
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down))
                        ],
                      ),
                      if (Get.find<LoadController>().isAgree == true) ...[
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
                      "불러오기",
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: () {
                      if (Get.find<LoadController>().ischecked == true) {
                        print("허용했어요");
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
