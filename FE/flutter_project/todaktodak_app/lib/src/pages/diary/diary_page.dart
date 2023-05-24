import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/config/palette.dart';
import 'package:test_app/src/controller/diary/diary_controller.dart';
import 'package:test_app/src/model/calendar/all_diary_model.dart';

class DiaryPage extends StatefulWidget {
  DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final _controller = Get.put(DiaryController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    _controller.fetchDiaryList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.greyColor,
        elevation: 0,
        title: appTitleWidget(_controller),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        child: Obx(
          () {
            final diaryList = _controller.selectedMonthDiaryList();
            return ListView(
              children: [
                for (var diary in diaryList) diaryListCard(diary, context),
              ],
            );
          },
        ),
      ),
    );
  }

  Column diaryListCard(AllDiaryModel diary, BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: () {
            final diaryId = diary.id;
            final eventDay = diary.date.toString().substring(0, 10);

            Get.toNamed('/detail/$diaryId', arguments: eventDay);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width - 32,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Image.asset('assets/images/score/${diary.rating}.png',
                    width: 60),
                Text(
                  '${diary.date.substring(0, 10)} ${diary.day}',
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // appTitle 위젯
  Row appTitleWidget(DiaryController controller) {
    bool isMonthTabSelected = controller.selectedTabIndex.value == 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            isMonthTabSelected ? controller.prevMonth() : controller.prevYear();
            setState(() {});
          },
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child: Center(
              child: Container(
                child: const Icon(
                  Icons.chevron_left_rounded,
                  color: Palette.blackTextColor,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Obx(
          () => Text(
            '${controller.currentYear}년',
            style: const TextStyle(
              color: Palette.blackTextColor,
              fontSize: 24,
            ),
          ),
        ),
        SizedBox(
          width: controller.selectedTabIndex.value == 0 ? 8 : 0,
        ),
        if (controller.selectedTabIndex.value == 0)
          Obx(
            () => Text(
              '${controller.currentMonth}월',
              style: const TextStyle(
                color: Palette.blackTextColor,
                fontSize: 24,
              ),
            ),
          ),
        const SizedBox(
          width: 14,
        ),
        GestureDetector(
          onTap: () {
            isMonthTabSelected ? controller.nextMonth() : controller.nextYear();
            setState(() {});
          },
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child: Center(
              child: Container(
                child: const Icon(
                  Icons.chevron_right_rounded,
                  color: Palette.blackTextColor,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
