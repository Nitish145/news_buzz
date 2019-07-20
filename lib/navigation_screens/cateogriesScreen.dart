import 'package:flutter/material.dart';

class CateogriesScreen extends StatefulWidget {
  @override
  _CateogriesScreenState createState() => _CateogriesScreenState();
}

class _CateogriesScreenState extends State<CateogriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Cateogries Screen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
