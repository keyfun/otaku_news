import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'dart:async';
import 'dart:convert' as convert;

class MyRssFeed {
  final RssFeed feed;

  MyRssFeed({this.feed});

  factory MyRssFeed.fromXml(xmlString) {
    RssFeed feed = new RssFeed.parse(xmlString);
    // print(feed.items.first);
    return MyRssFeed(feed: feed);
  }
}

Future<MyRssFeed> fetchRssFeed(String url) async {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    String result = convert.utf8.decode(response.bodyBytes);
    return MyRssFeed.fromXml(result);
  } else {
    throw Exception('Failed to load post');
  }
}
