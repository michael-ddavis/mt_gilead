import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/pages/signin_page.dart';
import 'package:mt_gilead/pages/signup_page.dart';
import 'package:mt_gilead/pages/forgot_password_page.dart';
import 'package:mt_gilead/pages/home_page.dart';
import 'package:mt_gilead/utils/theme_data.dart';


class AppRootWidget extends StatefulWidget {
  @override
  AppRootWidgetState createState() => new AppRootWidgetState();
}

class AppRootWidgetState extends State<AppRootWidget> {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _makeIOSApp() : _makeMaterialApp();
  }

  _makeMaterialApp() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: buildTheme(),
      routes: {
        '/': (context) => HomePage(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
      },
    );
  }

  _makeIOSApp() {
    return CupertinoApp(
      theme: CupertinoThemeData(
          primaryContrastingColor: Colors.amber,
          scaffoldBackgroundColor: CupertinoColors.white,
          primaryColor: Colors.purple,
          textTheme: CupertinoTextThemeData(
            primaryColor: CupertinoColors.black,
          )),
      routes: {
        '/': (context) => HomePage(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
      },
    );
  }
}
