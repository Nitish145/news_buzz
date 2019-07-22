import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_buzz/bookmarked_news_card.dart';
import 'package:news_buzz/progress/progress_bar.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: Padding(
                padding: const EdgeInsets.all(.0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection(snapshot.data.uid)
                        .snapshots(),
                    // ignore: missing_return
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> querySnapshot) {
                      if (querySnapshot.data != null) {
                        return ListView.builder(
                            itemCount: querySnapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              return BookmarkedNewsCard(
                                photoUrl: querySnapshot
                                    .data.documents[index].data["urlToImage"],
                                content: querySnapshot
                                    .data.documents[index].data["content"],
                                title: querySnapshot
                                    .data.documents[index].data["title"],
                                description: querySnapshot
                                    .data.documents[index].data["description"],
                                url: querySnapshot
                                    .data.documents[index].data["url"],
                              );
                            });
                      } else {
                        return Container(
                          child: Center(
                            child: ProgressBar(),
                          ),
                        );
                      }
                    }),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: ProgressBar(),
              ),
            );
          }
        });
  }
}
