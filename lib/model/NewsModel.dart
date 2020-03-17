import 'dart:convert';

NewsModel newsModelFromJson(String str) {
  final jsonData = json.decode(str);
  return NewsModel.fromJson(jsonData);
}

String newsModelToJson(NewsModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class NewsModel {
  String status;
  int totalResults;
  List<News> articles;

  NewsModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => new NewsModel(
    status: json["status"] == null ? null : json["status"],
    totalResults: json["totalResults"] == null ? null : json["totalResults"],
    articles: json["articles"] == null ? null : new List<News>.from(json["articles"].map((x) => News.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "totalResults": totalResults == null ? null : totalResults,
    "articles": articles == null ? null : new List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}

class News {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String content;
  Source source;

  News({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.content,
    this.source,
  });

  factory News.fromJson(Map<String, dynamic> json) => new News(
    author: json["author"] == null ? null : json["author"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    url: json["url"] == null ? null : json["url"],
    urlToImage: json["urlToImage"] == null ? null : json["urlToImage"],
    content: json["content"] == null ? null : json["content"],
    source: json["source"] == null ? null : Source.fromJson(json["source"]),
  );

  Map<String, dynamic> toJson() => {
    "author": author == null ? null : author,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "url": url == null ? null : url,
    "urlToImage": urlToImage == null ? null : urlToImage,
    "content": content == null ? null : content,
    "source": source == null ? null : source.toJson(),
  };
}

class Source {
  String id;
  String name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => new Source(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}