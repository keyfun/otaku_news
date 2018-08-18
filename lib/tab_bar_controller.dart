import 'package:flutter/material.dart';
import 'rss_list.dart';

class TabBarController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.work)),
                Tab(icon: Icon(Icons.web)),
                Tab(icon: Icon(Icons.watch)),
                Tab(icon: Icon(Icons.wifi)),
                Tab(icon: Icon(Icons.file_download)),
              ],
            ),
            title: Text('宅宅新聞'),
          ),
          body: TabBarView(
            children: [
              new RssList(url: "https://news.gamme.com.tw/feed"),
              new RssList(
                  url: "https://news.gamme.com.tw/category/movies/feed"),
              new RssList(
                  url: "https://news.gamme.com.tw/category/hotchick/feed"),
              new RssList(url: "https://news.gamme.com.tw/category/anime/feed"),
              new RssList(url: "https://share.dmhy.org/topics/rss/sort_id/2/rss.xml"),
            ],
          ),
        ),
      ),
    );
  }
}
