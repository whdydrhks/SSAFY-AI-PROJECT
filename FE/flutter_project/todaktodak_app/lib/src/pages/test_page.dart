import 'package:flutter/material.dart';
import 'package:test_app/src/components/analysis/drop_down_component.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);

  double _dropdownWidth = 150;
  String _selectedItem = '관계';
  final List<String> _items = <String>[
    '감정',
    '관계',
  ];

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropDownComponent(),
    );
  }
}
