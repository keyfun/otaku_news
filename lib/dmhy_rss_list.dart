import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'rss.dart';
import 'item.dart';
import 'news_list.dart';

const dmhy_main_url = "https://share.dmhy.org/topics/rss/rss.xml";

class DmhyRssList extends StatelessWidget {
  DmhyRssList({String url})
      : url = url,
        super(key: ObjectKey(url));

  final String url;

  List<Item> _getItems(List<RssItem> items) {
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
    return FutureBuilder<MyRssFeed>(
      future: fetchRssFeed(url),
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
    );
  }
}
