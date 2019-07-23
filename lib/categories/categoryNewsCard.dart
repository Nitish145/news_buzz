import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:news_buzz/globals.dart';
import 'package:news_buzz/top_headlines/top_headlines_model.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_buzz/checkIfDocumentExists.dart';

class CategoryNewsCard extends StatefulWidget {
  final Article newsArticle;

  const CategoryNewsCard({Key key, this.newsArticle}) : super(key: key);

  @override
  _CategoryNewsCardState createState() => _CategoryNewsCardState();
}

class _CategoryNewsCardState extends State<CategoryNewsCard> {
  @override
  Widget build(BuildContext context) {
    final Firestore databaseReference = Firestore.instance;

    Future<void> launchURL(BuildContext context, String url) async {
      try {
        await launch(
          url,
          option: new CustomTabsOption(
            toolbarColor: Theme.of(context).primaryColor,
            enableDefaultShare: true,
            enableUrlBarHiding: true,
            showPageTitle: true,
            animation: new CustomTabsAnimation(
              startEnter: 'slide_up',
              startExit: 'android:anim/fade_out',
              endEnter: 'android:anim/fade_in',
              endExit: 'slide_down',
            ),
          ),
        );
      } catch (e) {
        // An exception is thrown if browser app is not installed on Android device.
        debugPrint(e.toString());
      }
    }

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Bookmark',
          color: Theme.of(context).primaryColor,
          icon: Icons.bookmark_border,
          closeOnTap: true,
          onTap: () async {
            final FirebaseUser firebaseUser =
                await FirebaseAuth.instance.currentUser();
            bool isExisting = await isDocumentExisting(
                widget.newsArticle.title, firebaseUser.uid);
            if (isExisting) {
              categoryDetailSnackbarKey.currentState.showSnackBar(SnackBar(
                content: Text("Article already bookmarked"),
                duration: Duration(seconds: 3),
              ));
            } else {
              await databaseReference
                  .collection(firebaseUser.uid)
                  .document(widget.newsArticle.title)
                  .setData({
                "creation_timestamp": DateTime.now(),
                "id": widget.newsArticle.source.id,
                "name": widget.newsArticle.source.name,
                "author": widget.newsArticle.author,
                "title": widget.newsArticle.title,
                "description": widget.newsArticle.description,
                "url": widget.newsArticle.url,
                "urlToImage": widget.newsArticle.urlToImage,
                "publishedAt": widget.newsArticle.publishedAt,
                "content": widget.newsArticle.content,
              });
              categoryDetailSnackbarKey.currentState.showSnackBar(SnackBar(
                content: Text("Article Saved"),
                duration: Duration(seconds: 3),
              ));
            }
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () async {
            await launchURL(context, widget.newsArticle.url);
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.width,
            child: Card(
              child: Column(
                children: <Widget>[
                  Padding(
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 5.0),
                    child: Text(
                      widget.newsArticle.title ?? "",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 5.0),
                    child: Text(
                      widget.newsArticle.content ?? "",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
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
      ),
    );
  }
}
