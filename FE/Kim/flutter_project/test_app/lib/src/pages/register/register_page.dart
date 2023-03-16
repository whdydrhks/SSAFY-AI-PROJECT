import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/components/explain.dart';
import 'package:test_app/src/controller/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  @override
  const RegisterPage({super.key});
  static List<bool> register = [false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              width: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: const Color(0xffF1648A),
                  borderRadius: BorderRadius.circular(5)),
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
