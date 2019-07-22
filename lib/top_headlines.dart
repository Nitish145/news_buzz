import 'package:flutter/material.dart';
import 'package:news_buzz/top_headlines_service.dart';
import 'package:news_buzz/globals.dart';
import 'package:news_buzz/news_card.dart';

class ExtractTopHeadlines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: topHeadlinesList(),
    );
  }

  Widget topHeadlinesList() {
    return FutureBuilder(
        future: getTopHeadlines("in", apiKey),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: snapshot.data.articles.length,
                itemBuilder: (BuildContext context, int index) {
                  return NewsCard(newsArticle: snapshot.data.articles[index]);
                });
          }
        });
  }
}
