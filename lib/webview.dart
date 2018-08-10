import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/services.dart';
import 'item.dart';
import 'dart:async';

class _WebViewState extends State<WebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription _onDestroy;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _history = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    flutterWebviewPlugin.close();

    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      if (mounted) {
        _scaffoldKey.currentState.showSnackBar(
            const SnackBar(content: const Text('Webview Destroyed')));
      }
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        setState(() {
          print(state.type);
          if (state.type == WebViewState.finishLoad) {}
          _history.add('onStateChanged: ${state.type} ${state.url}');
        });
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onStateChanged.cancel();

    flutterWebviewPlugin.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: {
        "/": (_) => new Stack(children: <Widget>[
              new Center(child: CircularProgressIndicator()),
              new WebviewScaffold(
                url: widget.item.link,
                // appBar: new AppBar(
                //   backgroundColor: Colors.red,
                //   title: new Text(widget.item.title),
                // ),
                withLocalStorage: true,
              ),
            ])
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
