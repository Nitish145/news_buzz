import 'package:flutter/material.dart';

//check whether something is in progress
bool isProgressing = false;

String apiKey = "9160f228427c46be9f68160035ecca6e";

//top-headlines snackBar key
final GlobalKey<ScaffoldState> topHeadlinesSnackbarKey =
    new GlobalKey<ScaffoldState>();

//bookmark screen snackbar key
final GlobalKey<ScaffoldState> bookmarkSnackbarKey =
    new GlobalKey<ScaffoldState>();

//categoryDetail snackbar key
final GlobalKey<ScaffoldState> categoryDetailSnackbarKey =
    new GlobalKey<ScaffoldState>();
