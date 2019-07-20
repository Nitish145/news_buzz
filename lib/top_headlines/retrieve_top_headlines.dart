import 'package:flutter/material.dart';
import 'package:news_buzz/progress_bar.dart';
import 'package:news_buzz/top_headlines/top_headlines_service.dart';
import 'package:news_buzz/globals.dart';
import 'package:news_buzz/news_card.dart';

class RetrieveTopHeadlines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getTopHeadlines("in", apiKey),
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: ProgressBar(
                    dotOneColor: Theme
                        .of(context)
                        .primaryColor,
                    dotTwoColor: Colors.grey,
                    dotThreeColor: Theme
                        .of(context)
                        .primaryColor,
                  ));
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: <Widget>[
                  ListView.builder(
                      itemCount: snapshot.data.articles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NewsCard(
                            newsArticle: snapshot.data.articles[index]);
                      })
                ],
              );
            }
          }),
    );
  }
}
