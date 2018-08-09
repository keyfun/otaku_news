import 'package:flutter/material.dart';
import 'item.dart';
import 'webview.dart';

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
      ),
      body: Center(
        child: new WebView(item: widget.item,),
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key, this.item}) : super(key: key);

  final Item item;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}
