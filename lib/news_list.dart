import 'package:flutter/material.dart';
import 'item.dart';
import 'detail.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

typedef void OnTapCallback(Item item);

class NewsListItem extends StatelessWidget {
  NewsListItem({Item item, this.onTapCallback})
      : item = item,
        super(key: ObjectKey(item));

  final Item item;
  final OnTapCallback onTapCallback;

  Color _getColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    return TextStyle(
      color: Colors.black,
      decoration: TextDecoration.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTapCallback(item);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(item.title[0]),
      ),
      title:
          Text(item.title, style: _getTextStyle(context), textScaleFactor: 1.2),
      contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
    );
  }
}

class NewsList extends StatefulWidget {
  NewsList({Key key, this.items}) : super(key: key);

  final List<Item> items;

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  void _handleOnTap(Item item) {
    setState(() {
      _gotoDetail(item);
    });
  }

  void _gotoDetail(Item item) {
    // print('title = ${item.title}');
    // print('enclosureUrl = ${item.enclosureUrl}');
    var enclosureUrl = item.enclosureUrl;
    if (enclosureUrl == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailScreen(item: item)),
      );
    } else {
      // open BT App
      _openBT(enclosureUrl);
    }
  }

  _openBT(String url) async {
    print('openBT = $url');
    if (Platform.isIOS) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: widget.items.map((Item item) {
          return NewsListItem(
            item: item,
            onTapCallback: _handleOnTap,
          );
        }).toList(),
      ),
    );
  }
}
