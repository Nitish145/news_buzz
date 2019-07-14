import 'package:news_buzz/globals.dart';
import 'progress_bar.dart';
import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (isProgressing) {
      return Stack(
        children: <Widget>[
          Opacity(
            opacity: .85,
            child: const ModalBarrier(
              dismissible: false,
              color: Colors.black87,
            ),
          ),
          Center(
            child: ProgressBar(),
          )
        ],
      );
    }
    return Container();
  }
}
