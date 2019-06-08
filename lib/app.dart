import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/pages/home_page.dart';
import 'package:mt_gilead/pages/login/forgot_password_page.dart';
import 'package:mt_gilead/pages/login/signin_page.dart';
import 'package:mt_gilead/pages/login/signup_page.dart';
import 'package:mt_gilead/pages/store/AddFilterPage.dart';
import 'package:mt_gilead/pages/store/FavoritesPage.dart';
import 'package:mt_gilead/pages/store/ProductList.dart';
import 'package:mt_gilead/pages/store/ShoppingCartPage.dart';
import 'package:mt_gilead/pages/store/store_page.dart';
import 'package:mt_gilead/utils/Palatte.dart';


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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Palatte.primaryColor,
        accentColor: Palatte.secondaryColor,
        scaffoldBackgroundColor: Palatte.white,
  
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/store-home-page': (context) => StorePage(),
        '/favorites_page': (context) => FavoritesPage(),
        '/product_list': (context) => ProductList(),
        '/add-filter-page': (context) => AddFilterPage(),
        '/shopping-cart': (context) => ShoppingCartPage(),
      },
    );
  }

  _makeIOSApp() {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
          primaryContrastingColor: Palatte.secondaryColor,
          scaffoldBackgroundColor: CupertinoColors.white,
          primaryColor: Palatte.white,
          barBackgroundColor: Palatte.iOSWhite,
          textTheme: CupertinoTextThemeData(
            primaryColor: CupertinoColors.black,
          )),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/store-home-page': (context) => StorePage(),
        '/favorites_page': (context) => FavoritesPage(),
        '/product_list': (context) => ProductList(),
        '/add-filter-page': (context) => AddFilterPage(),
        '/shopping-cart': (context) => ShoppingCartPage(),
      },
    );
  }
}
