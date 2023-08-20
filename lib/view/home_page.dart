import 'package:flutter/material.dart';
import 'package:news_assignment/view/news_detail.dart';
import 'package:news_assignment/viewModel/NewsProvider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    inIt();
  }

  inIt() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final newsProvider = Provider.of<NewsProvider>(context, listen: false);

      newsProvider.fetchNews(context);
      newsProvider.fetchCategories(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: true);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: newsProvider.isSearchVisible
              ? GestureDetector(
                  onTap: () {
                    newsProvider.toggleSearch();
                  },
                  child: Icon(Icons.arrow_back_ios))
              : null,
          title: newsProvider.isSearchVisible
              ? TextField(
                  onChanged: (query) {
                    newsProvider.searchNews(context, query);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search news',
                    border: InputBorder.none,
                  ),
                )
              : Text('${newsProvider.appTitle} news'),
          actions: [
            IconButton(
              onPressed: () {
                newsProvider.toggleSearch();
              },
              icon: Icon(Icons.search),
            ),
            if (!newsProvider.isSearchVisible)
              PopupMenuButton<String>(
                onSelected: (sortBy) {
                  print("sort by ==  $sortBy");
                  newsProvider.setTitle(sortBy);
                  if (sortBy == "home") {
                    newsProvider.fetchNews(context);
                  } else {
                    newsProvider.fetchCategoriesNews(context, sortBy);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return newsProvider.categoriesList.map((category) {
                    return PopupMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList();
                },
              ),
          ],
        ),
        body: Consumer<NewsProvider>(
          builder: (context, newsProvider, _) {
            return newsProvider.newsItems.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : NewsDetail(
                    newsItem: newsProvider.currentNews,
                    onSwipeLeft: newsProvider.goToNextNews,
                    onSwipeRight: newsProvider.goToPreviousNews,
                  );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            newsProvider.fetchNews(context);
          },
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}
