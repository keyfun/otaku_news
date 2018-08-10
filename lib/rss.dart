import 'package:http/http.dart' as http;
import 'package:feedparser/feedparser.dart';
import 'dart:async';
import 'dart:convert' as convert;

class RssFeed {
  final Feed feed;

  RssFeed({this.feed});

  factory RssFeed.fromXml(xmlString) {
    Feed feed = parse(xmlString, strict: true);
    // print(feed.items.first);
    return RssFeed(feed: feed);
  }
}

Future<RssFeed> fetchRssFeed(String url) async {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    String result = convert.utf8.decode(response.bodyBytes);
    return RssFeed.fromXml(result);
  } else {
    throw Exception('Failed to load post');
  }
}
