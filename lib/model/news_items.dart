// To parse this JSON data, do
//
//     final newsItem = newsItemFromJson(jsonString);

import 'dart:convert';

List<NewsItem> newsItemFromJson(str) =>
    List<NewsItem>.from(str.map((x) => NewsItem.fromJson(x)));

String newsItemToJson(List<NewsItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsItem {
  String? id;
  String? title;
  String? description;
  String? url;
  String? author;
  String? image;
  String? language;
  List<String>? category;
  String? published;

  NewsItem({
    this.id,
    this.title,
    this.description,
    this.url,
    this.author,
    this.image,
    this.language,
    this.category,
    this.published,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) => NewsItem(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        author: json["author"],
        image: json["image"],
        language: json["language"],
        category: json["category"] == null
            ? []
            : List<String>.from(json["category"].map((x) => x)),
        published: json["published"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "url": url,
        "author": author,
        "image": image,
        "language": language,
        "category": category == null ? [] : category!.map((x) => x),
        "published": published,
      };
}
