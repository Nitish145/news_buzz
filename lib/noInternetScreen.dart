import 'package:flutter/material.dart';

class NoInternetScreen extends StatefulWidget {
  @override
  _NoInternetScreenState createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: RaisedButton(
          onPressed: () {
            setState(() {});
          },
          child: Center(
            child: Text("Retry"),
          ),
        ),
      ),
    );
  }
}
