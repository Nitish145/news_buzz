import 'package:flutter/material.dart';
import 'package:news_buzz/top_headlines/top_headlines.dart';

class HeadlinesScreen extends StatefulWidget {
  @override
  _HeadlinesScreenState createState() => _HeadlinesScreenState();
}

class _HeadlinesScreenState extends State<HeadlinesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtractTopHeadlines(),
    );
  }
}
