import 'package:flutter/material.dart';

void logoutDialog(BuildContext context, VoidCallback onLogout) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Log Out",
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 24),
          ),
          content: new Text("Are you sure you want to log out?"),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text(
                "STAY LOGGED IN",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            new FlatButton(
              child: new Text(
                "LOG OUT",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                Navigator.pop(context);
                onLogout();
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
          ],
        );
      });
}
