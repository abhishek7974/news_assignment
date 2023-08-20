import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_assignment/Api/Api.dart';
import 'package:news_assignment/Api/ConfigUrl.dart';

import 'package:news_assignment/model/news_items.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  NewsItem get currentNews => newsItems[_currentIndex];

  String appTitle = "home";

  List<NewsItem> newsItems = [];
  List<NewsItem> bookMarkedList = [];
  List<String> categoriesList = [];
  bool _isSearchVisible = false;

  int page = 1;

  bool get isSearchVisible => _isSearchVisible;

  Future<void> fetchNews(BuildContext context) async {
    _currentIndex = 0;
    final result = await DioApi.get(path: "${ConfigUrl.lattestNews}");
    if (result.response != null) {
      newsItems = newsItemFromJson(result.response?.data["news"]);

      notifyListeners();
    } else {
      result.handleError(context);
    }
  }

  Future<void> fetchCategories(BuildContext context) async {
    final result = await DioApi.get(path: "${ConfigUrl.categoriesNewsList}");
    if (result.response != null) {
      categoriesList = [];
      categoriesList = ["Home"];
      categoriesList =
          List<String>.from(result.response?.data["categories"].map((x) => x));
      categoriesList.insert(0, "home");
      print(categoriesList);
      notifyListeners();
    } else {
      result.handleError(context);
    }
  }

  Future<void> fetchCategoriesNews(
    BuildContext context,
    String category,
  ) async {
    _currentIndex = 0;
    final result =
        await DioApi.get(path: "${ConfigUrl.lattestNews}&category=$category");
    if (result.response != null) {
      newsItems = newsItemFromJson(result.response?.data["news"]);

      notifyListeners();
    } else {
      result.handleError(context);
    }
  }

  Future<void> searchNews(BuildContext context, String query) async {
    _currentIndex = 0;
    final result =
        await DioApi.get(path: "${ConfigUrl.searchNews}&keywords=$query");
    if (result.response != null) {
      newsItems = newsItemFromJson(result.response?.data["news"]);

      notifyListeners();
    } else {
      result.handleError(context);
    }
  }


   Future<void> updateBookmarks(List<NewsItem> newsList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final encodedList = prefs.getString('bookmarkedArticles');
  List<dynamic> existingBookmarks = [];
  if (encodedList != null) {
    existingBookmarks = json.decode(encodedList);
  }

  newsList.forEach((article) {
    bool isAlreadyBookmarked = existingBookmarks.any((existingArticle) =>
        existingArticle['id'] == article.id);
    if (!isAlreadyBookmarked) {
      existingBookmarks.add({
        'id': article.id,
        'title': article.title,
        'image': article.image,
        'description': article.description,
        'url': article.url,
      });
    }
  });

  prefs.setString('bookmarkedArticles', json.encode(existingBookmarks));
}

Future<void> getBookmarkedArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final encodedList = prefs.getString('bookmarkedArticles');
    
    if (encodedList != null) {
      final decodedList = json.decode(encodedList) as List<dynamic>;
       bookMarkedList = decodedList.map((article) => NewsItem(
        title: article['title'],
        id: article['id'],
        description: article['description'],
        url: article['url'],
        image: article['image'],
        
      )).toList();
      
      notifyListeners();
    } 
  }


  Future<bool> isArticleBookmarked(String newsItemId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final encodedList = prefs.getString('bookmarkedArticles');
  
  if (encodedList != null) {
    final decodedList = json.decode(encodedList) as List<dynamic>;
    List<NewsItem> bookMarkedList = decodedList.map((article) => NewsItem(
      title: article['title'],
      id: article['id'],
      description: article['description'],
      url: article['url'],
      image: article['image'],
    )).toList();
    
    return bookMarkedList.any((article) => article.id == newsItemId);
  }
  
  return false;
}




Future<void> removeBookmark(String newsItemId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final encodedList = prefs.getString('bookmarkedArticles');
  List<dynamic> existingBookmarks = [];
  if (encodedList != null) {
    existingBookmarks = json.decode(encodedList);
  }

  existingBookmarks.removeWhere((existingArticle) =>
      existingArticle['id'] == newsItemId);

  prefs.setString('bookmarkedArticles', json.encode(existingBookmarks));
}

  void setPage(int pageIdx) {
    page = pageIdx;
    notifyListeners();
  }

  void goToNextNews() {
    print("currentIndex $currentIndex");
    if (currentIndex < newsItems.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void goToPreviousNews() {
    print("currentIndex $currentIndex");
    if (currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  Future<void> openUrl(String url) async {
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      print("something went wrong in $e");
    }
  }

  void toggleSearch() {
    _isSearchVisible = !_isSearchVisible;
    notifyListeners();
  }

  void setTitle(String title) {
    appTitle = title;
    notifyListeners();
  }
}
