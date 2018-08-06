import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:feedparser/feedparser.dart';

// https://news.gamme.com.tw/feed
// https://news.gamme.com.tw/category/movies/feed
// https://news.gamme.com.tw/category/hotchick/feed
// https://news.gamme.com.tw/category/anime/feed

class RssFeed {
  final Feed feed;

  RssFeed({this.feed});

  factory RssFeed.fromXml(xmlString) {
    Feed feed = parse(xmlString, strict: true);
    // print(feed.items.first);
    return RssFeed(feed: feed);
  }
}

Future<RssFeed> fetchRssFeed() async {
  final response = await http.get('https://news.gamme.com.tw/feed');
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the XML
    return RssFeed.fromXml(response.body);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}