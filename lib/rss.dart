import 'dart:async';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:feedparser/feedparser.dart';
import 'package:xml/xml.dart' as xml;
import 'package:xml2json/xml2json.dart';

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
  final Map<String, String> headers = {
    HttpHeaders.CONTENT_TYPE: 'application/rss+xml; charset=utf-8'
  };

  final response =
      await http.get('https://news.gamme.com.tw/feed', headers: headers);
  if (response.statusCode == 200) {
    // print(response.headers);
    // final Xml2Json myTransformer = new Xml2Json();
    // myTransformer.parse(response.body);
    // String json = myTransformer.toGData();
    // print(json);
    // If server returns an OK response, parse the XML
    return RssFeed.fromXml(response.body);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}
