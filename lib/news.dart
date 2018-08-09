import 'package:flutter/material.dart';
import 'package:feedparser/feedparser.dart';
import 'rss.dart';
import 'detail.dart';
import 'item.dart';

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
      title: Text(item.title, style: _getTextStyle(context), textScaleFactor: 1.2),
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
    print(item.title);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailScreen(item: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('宅宅新聞'),
        // backgroundColor: Colors.black,
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

class NewsApp extends StatelessWidget {
  List<Item> _getItems(List<FeedItem> items) {
    List<Item> newItems = List<Item>();
    items.forEach((feedItem) {
      Item item = Item(feedItem.title, feedItem.description, feedItem.link,
          feedItem.pubDate);
      newItems.add(item);
    });
    return newItems;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Otaku News',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: FutureBuilder<RssFeed>(
        future: fetchRssFeed(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data.feed.items);
            return NewsList(items: _getItems(snapshot.data.feed.items));
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner
          return new Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
