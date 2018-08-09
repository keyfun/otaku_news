import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'item.dart';

class _WebViewState extends State<WebView> {
@override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: {
        "/": (_) => new WebviewScaffold(
              url: widget.item.link,
              appBar: new AppBar(
                title: new Text(widget.item.title),
              ),
            )
      },
    );
  }
}

class WebView extends StatefulWidget {
  WebView({Key key, this.item}) : super(key: key);

  final Item item;

  @override
  _WebViewState createState() => _WebViewState();
}
