import 'package:flutter/material.dart';
import 'package:news_buzz/authentication/authentication.dart';
import 'package:news_buzz/authentication/root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewsBuzz',
      theme: ThemeData(
          primaryColor: Colors.redAccent,
          primaryColorDark: Colors.red,
          primarySwatch: Colors.red,
          cursorColor: Colors.red),
      home: new RootPage(Auth()),
    );
  }
}
