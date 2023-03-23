import 'package:flutter/material.dart';

class DiaryDetailAppbar extends StatelessWidget {
  const DiaryDetailAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: DropdownButton(
      items: [
        DropdownMenuItem(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.edit,
                color: Color(0xff707070),
              ),
              SizedBox(
                width: 18,
              ),
              Text(
                "수정하기",
                style: TextStyle(color: Color(0xff707070)),
              )
            ],
          ),
          value: 'option1',
        ),
        DropdownMenuItem(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.delete,
                color: Color(0xff707070),
              ),
              SizedBox(
                width: 18,
              ),
              Text("삭제하기", style: TextStyle(color: Color(0xff707070))),
            ],
          ),
          value: 'option2',
        ),
      ],
      onChanged: (value) {
        print(value);
      },
      icon: Icon(Icons.more_horiz_outlined),
    ));
  }
}
