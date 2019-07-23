import 'package:flutter/material.dart';
import 'package:news_buzz/authentication/authentication.dart';
import 'package:news_buzz/categories/cateogries_grid_view_screen.dart';
import 'package:news_buzz/navigation_screens/bookmarkScreen.dart';
import 'package:news_buzz/navigation_screens/headlinesScreen.dart';
import 'package:news_buzz/authentication/logout_dialog.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    Widget getDynamicBody() {
      switch (_currentIndex) {
        case 0:
          {
            return HeadlinesScreen();
          }
          break;
        case 1:
          {
            return CategoriesGridView();
          }
          break;
        case 2:
          {
            return BookmarkScreen();
          }
          break;
      }
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("NewsBuzz"),
        backgroundColor: Theme.of(context).primaryColor,
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
      body: getDynamicBody(),
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
            backgroundColor: Theme.of(context).primaryColor,
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
            backgroundColor: Theme.of(context).primaryColor,
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
            backgroundColor: Theme.of(context).primaryColor,
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
