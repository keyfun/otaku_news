import 'dart:async';
import 'dart:convert' as convert;
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
  final String url = 'https://news.gamme.com.tw/feed';
  final response =
      await http.get(url);
  if (response.statusCode == 200) {
    String result = convert.utf8.decode(response.bodyBytes);
    // If server returns an OK response, parse the XML
    return RssFeed.fromXml(result);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}
