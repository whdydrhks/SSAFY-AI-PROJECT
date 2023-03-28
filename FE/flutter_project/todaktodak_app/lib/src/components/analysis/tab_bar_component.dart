import 'package:flutter/material.dart';
import 'package:test_app/src/config/palette.dart';

class TabBarComponent extends StatefulWidget {
  const TabBarComponent({Key? key}) : super(key: key);

  @override
  State<TabBarComponent> createState() => _TabBarComponentState();
}

class _TabBarComponentState extends State<TabBarComponent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: Palette.blackTextColor,
      indicatorColor: Palette.blackTextColor,
      unselectedLabelColor: Palette.blackTextColor,
      labelStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Jua_Regular',
      ),
      // indicatorPadding: const EdgeInsets.symmetric(horizontal: 32.0),
      indicator: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffF1648A),
            width: 3,
          ),
        ),
      ),
      onTap: (value) {
        print('하이 $value');
      },
      controller: _tabController,
      tabs: [
        Tab(
          text: '월간',
        ),
        Tab(
          text: '연간',
        ),
      ],
    );
  }
}
