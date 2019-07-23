import 'package:flutter/material.dart';
import 'package:news_buzz/categories/categoryNewsCard.dart';
import 'package:news_buzz/categories/getCategoryHeadlines.dart';
import 'package:news_buzz/globals.dart';
import 'package:news_buzz/progress/progress_bar.dart';

class CategoriesDetailScreen extends StatefulWidget {
  final String categoryName;
  final String categoryId;

  const CategoriesDetailScreen({Key key, this.categoryId, this.categoryName})
      : super(key: key);

  @override
  _CategoriesDetailScreenState createState() => _CategoriesDetailScreenState();
}

class _CategoriesDetailScreenState extends State<CategoriesDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: categoryDetailSnackbarKey,
      appBar: AppBar(
        title: Text("${widget.categoryName} News"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getCategoryHeadlines(widget.categoryId, apiKey),
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: ProgressBar(
                dotOneColor: Theme.of(context).primaryColor,
                dotTwoColor: Colors.grey,
                dotThreeColor: Theme.of(context).primaryColor,
              ));
            } else if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.articles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CategoryNewsCard(
                        newsArticle: snapshot.data.articles[index]);
                  });
            }
          }),
    );
  }
}
