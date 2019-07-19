import 'package:flutter/material.dart';
import 'package:news_buzz/authentication.dart';
import 'package:news_buzz/top_headlines.dart';
import 'logout_dialog.dart';

class HomePage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  const HomePage({Key key, this.auth, this.onSignedOut}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;

  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    ExtractTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NewsBuzz"),
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        actions: <Widget>[
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                  child: CircleAvatar(
                      child: Image.asset("assets/images/logout_icon.png"))),
            ),
            onTap: () {
              logoutDialog(context, _signOut);
            },
          )
        ],
      ),
      body: ExtractTopHeadlines(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            icon: Icon(
              Icons.menu,
              size: 30,
              color: Colors.white,
            ),
            title: Text(
              "Headlines",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            icon: Icon(
              Icons.apps,
              size: 30,
              color: Colors.white,
            ),
            title: Text(
              "Cateogries",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            icon: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
            title: Text(
              "Search",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            icon: Icon(
              Icons.bookmark,
              size: 30,
              color: Colors.white,
            ),
            title: Text(
              "Bookmarked",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
