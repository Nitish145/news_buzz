import 'package:flutter/material.dart';
import 'package:news_buzz/categoriesList.dart';
import 'categoriesDetailScreen.dart';
import 'package:news_buzz/globals.dart';

class CategoriesGridView extends StatefulWidget {
  @override
  _CategoriesGridViewState createState() => _CategoriesGridViewState();
}

class _CategoriesGridViewState extends State<CategoriesGridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: topHeadlinesSnackbarKey,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: categoriesList.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoriesDetailScreen(
                                categoryId: categoriesList[index]["id"],
                                categoryName: categoriesList[index]["name"],
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 5,
                    color: categoriesList[index]["color"],
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 20.0),
                          child: Center(
                              child: Icon(
                            categoriesList[index]["icon"],
                            size: 60,
                            color: Colors.white,
                          )),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 16.0),
                          child: Center(
                              child: Text(
                            categoriesList[index]["name"],
                            maxLines: 2,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
