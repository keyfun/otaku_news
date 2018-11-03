import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/services.dart';
import 'item.dart';
import 'dart:async';

class _WebViewState extends State<WebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription _onDestroy;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  final _history = [];
  var currentUrl = "";

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    flutterWebviewPlugin.close();

    // flutterWebviewPlugin.onUrlChanged.listen((String url) {
    //   print("onUrlChanged: $url");
    // });

    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      if (mounted) {
        print("WebView onDestroy");
      }
      // hotfix for disable loader when tap system back button
      Navigator.pop(context);
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        setState(() {
          print('state.type = ${state.type}');
          if (state.type == WebViewState.startLoad) {
            print('startLoad: ${state.url}');
            // TODO: stop it if same viewing url
            // if (currentUrl == state.url) {
            //   flutterWebviewPlugin.stopLoading();
            // }
          } else if (state.type == WebViewState.finishLoad) {
            print('finishLoad: ${state.url}');
            _history.add('onStateChanged: ${state.type} ${state.url}');
            currentUrl = state.url;
          }
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
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return new WebviewScaffold(
        url: widget.item.link,
        withLocalStorage: true,
        // iOS only
        bottomNavigationBar: new FlatButton(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: new Icon(Icons.backspace),
            onPressed: () {
              Navigator.pop(context);
            }),
      );
    } else {
      return new WebviewScaffold(
        url: widget.item.link,
        withLocalStorage: true,
      );
    }
  }
}

class WebView extends StatefulWidget {
  WebView({Key key, this.item}) : super(key: key);

  final Item item;

  @override
  _WebViewState createState() => _WebViewState();
}
