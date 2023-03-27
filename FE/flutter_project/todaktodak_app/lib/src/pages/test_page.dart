import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

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
    return Container(
      width: 300,
      child: DropdownButton<String>(
        value: widget._selectedItem,
        onChanged: (String? newValue) {
          setState(() {
            widget._selectedItem = newValue!;
          });
        },
        items: widget._items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(width: 100, child: Text(value)),
          );
        }).toList(),
      ),
    );
  }
}
