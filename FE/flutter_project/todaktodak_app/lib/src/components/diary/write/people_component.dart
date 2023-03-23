import 'package:flutter/material.dart';

class PeopleComponent extends StatelessWidget {
  PeopleComponent({super.key});
  final peopleList = [
    "assets/images/family.png",
    "assets/images/friends.png",
    "assets/images/couple.png",
    "assets/images/person.png",
    "assets/images/solo.png",
  ];
  _box() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 0.5,
            color: Color(0x35531F13),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 120,
      decoration: _box(),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "사람",
            style: TextStyle(fontSize: 24),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: peopleList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 60,
                  height: 60,
                  child: Padding(
                      padding: EdgeInsets.only(left: 18),
                      child: Image.asset(peopleList[index])),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
