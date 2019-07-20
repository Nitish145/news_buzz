import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_buzz/article_webview.dart';
import 'package:news_buzz/top_headlines/top_headlines_model.dart';
import 'package:transparent_image/transparent_image.dart';

class NewsCard extends StatefulWidget {
  final Article newsArticle;

  const NewsCard({Key key, this.newsArticle}) : super(key: key);

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  var randomNumberGenerator = new Random();

  @override
  Widget build(BuildContext context) {
    int randomInt = randomNumberGenerator.nextInt(100);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  /*NewsDetailScreen(
                  newsArticle: widget.newsArticle,
                  randomIntDefiningHero: randomInt,
                ),*/
                  ArticleWebView(
                    articleUrl: widget.newsArticle.url,
                  )));
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 2.5,
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Column(
              children: <Widget>[
                Hero(
                  tag: "NewsPic$randomInt",
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: FadeInImage.memoryNetwork(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 4,
                          fit: BoxFit.fill,
                          placeholder: kTransparentImage,
                          image: widget.newsArticle.urlToImage ??
                              "https://www.jainsusa.com/images/store/agriculture/not-available.jpg"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 5.0),
                  child: Text(
                    widget.newsArticle.title ?? "",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 5.0),
                  child: Text(
                    widget.newsArticle.content ?? "",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
