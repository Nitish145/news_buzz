import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ArticleWebView extends StatefulWidget {
  final String articleUrl;

  const ArticleWebView({Key key, this.articleUrl}) : super(key: key);

  @override
  _ArticleWebViewState createState() => _ArticleWebViewState();
}

class _ArticleWebViewState extends State<ArticleWebView> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.articleUrl,
      appBar: AppBar(
        title: Text("Article Details"),
      ),
    );
  }
}
