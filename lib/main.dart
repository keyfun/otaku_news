import 'package:flutter/material.dart';
import 'tab_bar_controller.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new TabBarController(),
    );
  }
}