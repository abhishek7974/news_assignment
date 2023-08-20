import 'package:flutter/material.dart';
import 'package:news_assignment/model/news_items.dart';
import 'package:news_assignment/viewModel/NewsProvider.dart';
import 'package:provider/provider.dart';

class NewsDetail extends StatefulWidget {
  final NewsItem newsItem;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;

  NewsDetail({
    required this.newsItem,
    required this.onSwipeLeft,
    required this.onSwipeRight,
  });

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {


  
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    return GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            widget.onSwipeRight();
          } else {
            widget.onSwipeLeft();
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              // padding: EdgeInsets.all(16.0),
              children: [
                Image.network(widget.newsItem.image ?? "",
                    errorBuilder: (context, error, stackTrace) {
                  return Container(); // Return an empty container on image load error
                }),
                SizedBox(height: 16.0),
                Text(
                  widget.newsItem.title ?? "",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  widget.newsItem.description ?? "",
                  style: TextStyle(fontSize: 16.0),
                ),
                Row(
                  children: [

                  ],
                ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: () async {
                    print("news url ${widget.newsItem.url}");
                    await newsProvider.openUrl(widget.newsItem.url ?? "");
                  },
                  child: Text('Read More'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          widget.onSwipeRight();
                        },
                        child: Icon(Icons.arrow_left_outlined)),
                    InkWell(
                        onTap: () {
                          widget.onSwipeLeft();
                        },
                        child: Icon(Icons.arrow_right_outlined))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
