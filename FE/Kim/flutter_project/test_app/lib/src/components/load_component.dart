import 'package:flutter/material.dart';

class LoadComponent extends StatelessWidget {
  const LoadComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Center(
          child: Container(
            child: Text("불러오기"),
          ),
        ),
      ]),
    );
  }
}
