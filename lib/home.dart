import 'package:flutter/material.dart';
import 'package:flutterplay/custom_dropdown/custom_dropdown_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List fruitList = [
    "apple",
    "banana",
    "kiwi",
    "orange",
    "grapes",
    "dragonfruit"
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          child: Center(
              child: CustomDropdown(
        text: fruitList[selectedIndex],
        onTap: (val) {
          setState(() {
            selectedIndex = val;
          });
        },
        itemList: fruitList,
      ))),
    );
  }
}
