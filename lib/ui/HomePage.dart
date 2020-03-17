import 'package:news_app/model/NewsModel.dart';
import 'package:news_app/model/NewsInsertModel.dart';
import 'package:news_app/ui/NewsSummary.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NewsInsert> newsInsert = [];
  void apiCall() async {
    var x = await dioCall();
    print(x);
  }

  Future<int> dioCall() async {
    loadingView();
    try {
      Response response = await Dio().get(
          "http://newsapi.org/v2/top-headlines?sources=google-news&apiKey=c06c776c356f4cfd9eef7fdb4e3c26ac");
      print(response);
      final newsModel = newsModelFromJson(response.toString());

      print("Api Call :: > ${newsModel.toJson()['articles']}");

      var list = newsModel.toJson()['articles'] as List;
      print(list.length);
      print(list.runtimeType); //returns List<dynamic>
      List<News> newsList = list.map((i) => News.fromJson(i)).toList();
      print(newsList.length);
      var list2 = newsList[0].title;
      Source list1 = newsList[0].source;
      List<NewsInsert> newsInsertTemp = [];
      newsInsertTemp.clear();
      for (var i = 0; i < newsList.length; i++) {
        print("i data:${i}");
        NewsInsert insert = new NewsInsert(
            newsList[i].title,
            newsList[i].description,
            newsList[i].description,
            newsList[i].urlToImage);
        newsInsertTemp.add(insert);
      }

      newsInsert.clear();
      setState(() {
        newsInsert.addAll(newsInsertTemp);
      });
      print("Api phone x :: > ${list1.name}"); //returns List<dynamic>
      print("Api phone list2 x :: > ${list2}"); //returns List<dynamic>
    } catch (e) {
      print(e);
    }
    print("Api Callx :: > ${newsInsert[0].title}");
    return 10;
  }

  @override
  void initState() {
    loadingView();
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Container(
          color: new Color(0xFF736AB7),
          child: new CustomScrollView(
            scrollDirection: Axis.vertical,
            shrinkWrap: false,
            slivers: <Widget>[
              new SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                sliver: new SliverList(
                  delegate: new SliverChildBuilderDelegate(
                        (context, index) => new NewsSummary(newsInsert[index]),
                    childCount: newsInsert.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          loadingView();
          apiCall();
        },
        child: Icon(Icons.refresh),
        backgroundColor: Colors.blue,
      ),
    );
  }

  // Progress indicator widget to show loading.
  Widget loadingView() => Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.red,
    ),
  );
}
