import 'package:flutter/material.dart';
import 'package:feedparser/feedparser.dart';
import 'package:http/http.dart';

// https://news.gamme.com.tw/feed
// https://news.gamme.com.tw/category/movies/feed
// https://news.gamme.com.tw/category/hotchick/feed
// https://news.gamme.com.tw/category/anime/feed

class Item {
  Item(this.title, this.description, this.link, this.date);

  final String title;
  final String description;
  final String link;
  final String date;
}

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
      color: Colors.black54,
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
      title: Text(item.title, style: _getTextStyle(context)),
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
  Set<Item> _items = Set<Item>();

  void _handleOnTap(Item item) {
    setState(() {
      // goto details page
      print(item.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('宅宅新聞'),
      ),
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

// test Data
final List<Item> data = <Item>[
  Item('AAA', 'BBB', 'CCC', 'DDD'),
  Item('AAA', 'BBB', 'CCC', 'DDD'),
  Item('AAA', 'BBB', 'CCC', 'DDD'),
  Item('AAA', 'BBB', 'CCC', 'DDD'),
  Item('AAA', 'BBB', 'CCC', 'DDD'),
  Item('AAA', 'BBB', 'CCC', 'DDD'),
];

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Otaku News',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: NewsList(items: data),
    );
  }
}
