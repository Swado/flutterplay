import 'package:flutter/material.dart';
import 'package:flutterplay/custom_dropdown/custom_dropdown_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
          Container(child: Center(child: CustomDropdown(text: "My drop down"))),
    );
  }
}
