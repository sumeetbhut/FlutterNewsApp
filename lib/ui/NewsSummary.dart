import 'package:flutter/material.dart';
import 'package:news_app/model/NewsInsertModel.dart';
import 'package:news_app/ui/DetailPage.dart';
import 'package:news_app/utils/separator.dart';
import 'package:news_app/ui/NewsSummary.dart';
import 'package:news_app/utils/text_style.dart';

class NewsSummary extends StatelessWidget {

  final NewsInsert news;
  final bool horizontal;

  NewsSummary(this.news, {this.horizontal = true});

  NewsSummary.vertical(this.news): horizontal = false;


  @override
  Widget build(BuildContext context) {

    final newsThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
        vertical: 10.0
      ),
      alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: new Hero(
          tag: "news-hero-${news.title}",
          child: new Container(
              width: 100.0,
              height: 100.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          news.imglink)
                  )
              )),
      ),
    );



    final newsCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(news.title, style: TextStyle(color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
            maxLines: 4,),
        ],
      ),
    );


    final newsCard = new Container(
      child: newsCardContent,
      height: horizontal ? 124.0 : 154.0,
      margin: horizontal
        ? new EdgeInsets.only(left: 46.0)
        : new EdgeInsets.only(top: 72.0),
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );


    return new GestureDetector(
      onTap: horizontal
          ? () => Navigator.of(context).push(
            new PageRouteBuilder(
              pageBuilder: (_, __, ___) => new DetailPage(news),
              transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                new FadeTransition(opacity: animation, child: child),
              ) ,
            )
          : null,
      child: new Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            newsCard,
            newsThumbnail,
          ],
        ),
      )
    );
  }
}
