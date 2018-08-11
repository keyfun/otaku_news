import 'package:flutter/material.dart';
import 'item.dart';
import 'webview.dart';
import 'dart:async';

class _DetailScreenState extends State<DetailScreen> {
  // handle system back button
  Future<bool> _onWillPop() {
    print("onWillPop");
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop, child: new WebView(item: widget.item));
  }
}

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key, this.item}) : super(key: key);

  final Item item;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}
