import 'package:flutter/material.dart';
import 'package:news_buzz/authentication.dart';
import 'globals.dart';
import 'progress_screen.dart';

class LoginScreen extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  const LoginScreen({Key key, this.auth, this.onSignedIn}) : super(key: key);

  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  String _loginErrorMessage = "";
  String _signupErrorMessage = "";

  // Check if form is valid before signup
  bool _validateSignupAndSave() {
    final form = _signupFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Check if form is valid before login
  bool _validateLoginAndSave() {
    final form = _loginFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Verify your account",
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          ),
          content: new Text(
            "Link to verify account has been sent to your email",
            style: TextStyle(color: Colors.black38),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _validateLoginAndSubmit() async {
    if (_validateLoginAndSave()) {
      try {
        setState(() {
          isProgressing = true;
        });
        String userId = await widget.auth.signIn(_email, _password);
        print("Signed in: $userId");
        widget.auth.isEmailVerified().then((isEmailVerified) {
          if (isEmailVerified) {
            setState(() {
              _loginErrorMessage = "";
              isProgressing = false;
            });
            widget.onSignedIn();
          } else {
            setState(() {
              isProgressing = false;
              _loginErrorMessage =
              "Please verify your email to log into your account";
            });
          }
        });
      } catch (e) {
        setState(() {
          isProgressing = false;
          _loginErrorMessage = e.message.toString();
        });
      }
    }
  }

  Future<void> _validateSignupAndSubmit() async {
    if (_validateSignupAndSave()) {
      try {
        setState(() {
          isProgressing = true;
        });
        String userId = await widget.auth.signUp(_email, _password);
        print("Signed Up: $userId");
        setState(() {
          isProgressing = false;
          _signupErrorMessage = "";
        });
        await widget.auth.sendEmailVerification();
        _showVerifyEmailSentDialog();
      } catch (e) {
        setState(() {
          isProgressing = false;
          _signupErrorMessage = e.message.toString();
        });
      }
    }
  }

  Widget homePage() {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage('assets/images/mountains.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 200.0),
            child: Center(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 50.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "News ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                  ),
                ),
                Text(
                  " BUZZ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new OutlineButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.redAccent,
                    highlightedBorderColor: Colors.white,
                    onPressed: () => navigateToSignup(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed: () => navigateToLogin(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget loginPage() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.05), BlendMode.dstATop),
                image: AssetImage('assets/images/mountains.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Form(
              key: _loginFormKey,
              child: new ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(120.0, 90.0, 120.0, 50.0),
                    child: Center(
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.redAccent,
                        size: 70.0,
                      ),
                    ),
                  ),
                  new Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 10.0),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                      color: Colors.redAccent, width: 5.0)),
                            ),
                            validator: (email) {
                              bool isEmailValid = RegExp(
                                  r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(email);
                              if (!isEmailValid) {
                                return "Please Enter a valid e-mail";
                              }
                              return null;
                            },
                            onSaved: (email) => _email = email,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 24.0,
                  ),
                  new Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 10.0),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: TextFormField(
                            obscureText: true,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                      color: Colors.redAccent, width: 5.0)),
                            ),
                            validator: (String password) {
                              if (password.isEmpty) {
                                return "Please Enter Password";
                              }
                              return null;
                            },
                            onSaved: (String password) {
                              _password = password;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 24.0,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: new InkWell(
                          child: new Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.redAccent,
                              fontSize: 15.0,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          onTap: () => {},
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        child: Text(
                          _loginErrorMessage,
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  new Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 20.0),
                    alignment: Alignment.center,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new FlatButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: Colors.redAccent,
                            onPressed: () async {
                              await _validateLoginAndSubmit();
                              if (_validateLoginAndSave()) {
                                _loginFormKey.currentState.reset();
                              }
                            },
                            child: new Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 10.0,
                              ),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Expanded(
                                    child: Text(
                                      "LOGIN",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 20.0),
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            margin: EdgeInsets.all(8.0),
                            decoration:
                            BoxDecoration(border: Border.all(width: 0.25)),
                          ),
                        ),
                        Text(
                          "OR CONNECT WITH",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        new Expanded(
                          child: new Container(
                            margin: EdgeInsets.all(8.0),
                            decoration:
                            BoxDecoration(border: Border.all(width: 0.25)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                            child: new CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                              Image
                                  .asset("assets/images/google_icon.png")
                                  .image,
                            ),
                            onTap: () async {
                              String uid = await widget.auth.signInWithGoogle();
                              print("Signed in: $uid");
                              widget.onSignedIn();
                            }),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ProgressScreen(),
        ],
      ),
    );
  }

  Widget signupPage() {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.05), BlendMode.dstATop),
                image: AssetImage('assets/images/mountains.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Form(
              key: _signupFormKey,
              child: new ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(120.0, 120.0, 120.0, 90.0),
                    child: Center(
                      child: Icon(
                        Icons.person_add,
                        color: Colors.redAccent,
                        size: 50.0,
                      ),
                    ),
                  ),
                  new Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 10.0),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                      color: Colors.redAccent, width: 5.0)),
                            ),
                            validator: (email) {
                              bool isEmailValid = RegExp(
                                  r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(email);
                              if (!isEmailValid) {
                                return "Please Enter a valid e-mail";
                              }
                              return null;
                            },
                            onSaved: (email) => _email = email,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 24.0,
                  ),
                  new Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 10.0),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: TextFormField(
                            obscureText: true,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                      color: Colors.redAccent, width: 5.0)),
                            ),
                            validator: (String password) {
                              if (password.isEmpty) {
                                return "Please Enter Password";
                              }
                              return null;
                            },
                            onSaved: (String password) {
                              _password = password;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 24.0,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        child: Text(
                          _signupErrorMessage,
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  new Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 50.0),
                    alignment: Alignment.center,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new FlatButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: Colors.redAccent,
                            onPressed: () async {
                              await _validateSignupAndSubmit();
                              if (_validateSignupAndSave()) {
                                _signupFormKey.currentState.reset();
                              }
                            },
                            child: new Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 10.0,
                              ),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Expanded(
                                    child: Text(
                                      "SIGN UP",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ProgressScreen(),
        ],
      ),
    );
  }

  navigateToLogin() {
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  navigateToSignup() {
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  PageController _controller =
      new PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: PageView(
            controller: _controller,
            physics: new AlwaysScrollableScrollPhysics(),
            children: <Widget>[loginPage(), homePage(), signupPage()],
            scrollDirection: Axis.horizontal,
          )),
    );
  }
}
