import 'package:flutter/material.dart';
import 'package:news_buzz/top_headlines/top_headlines_model.dart';
import 'package:transparent_image/transparent_image.dart';

class NewsDetailScreen extends StatelessWidget {
  final int randomIntDefiningHero;
  final Article newsArticle;

  const NewsDetailScreen(
      {Key key, this.newsArticle, this.randomIntDefiningHero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Headlines Detail"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Hero(
              tag: "NewsPic$randomIntDefiningHero",
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: FadeInImage.memoryNetwork(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                      fit: BoxFit.fill,
                      placeholder: kTransparentImage,
                      image: newsArticle.urlToImage),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: Text(
                newsArticle.title ?? "",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: Text(
                newsArticle.content ?? "",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                softWrap: true,
                maxLines: 12,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
