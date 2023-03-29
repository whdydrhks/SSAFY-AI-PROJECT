import 'package:flutter/material.dart';
import 'package:test_app/main.dart';
import 'package:test_app/src/config/mode.dart';

import '../../components/auth/load_component.dart';
import '../../components/auth/register_component.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: ValueListenableBuilder<ThemeMode>(
            valueListenable: MyApp.themeNotifier,
            builder: (_, ThemeMode currentMode, __) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.height,
                          height: 64,
                          decoration: BoxDecoration(
                              color: Mode.boxMode(currentMode),
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: TabBar(
                                  labelColor: Colors.white,
                                  indicatorColor: Colors.white,
                                  unselectedLabelColor: const Color(0xff7B7B7B),
                                  indicator: BoxDecoration(
                                      color: const Color(0xffF1648A),
                                      borderRadius: BorderRadius.circular(5)),
                                  controller: tabController,
                                  labelStyle: TextStyle(
                                      fontSize: 20, fontFamily: 'Jua_Regular'),
                                  tabs: const [
                                    Tab(
                                      text: "회원가입",
                                    ),
                                    Tab(text: "불러오기"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: TabBarView(
                                controller: tabController,
                                children: [
                              RegisterComponent(),
                              const LoadComponent()
                            ]))
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
