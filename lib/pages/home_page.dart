import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/state.dart';
import 'package:mt_gilead/pages/logout_page.dart';
import 'package:mt_gilead/pages/signin_page.dart';
import 'package:mt_gilead/pages/store_page.dart';
import 'package:mt_gilead/utils/loading.dart';
import 'package:mt_gilead/utils/state_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  StateModel appState;
  bool _loadingVisible = false;

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _pages = [
    LogoutPage(),
    StorePage(),
    //ProductList(),
  ];

  @override
  Widget build(BuildContext context) {
    Widget platformUI;
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
        return _androidHomePage(context);
        break;
      case TargetPlatform.iOS:
        platformUI = _iOSHomePage(context);
        break;
      case TargetPlatform.fuchsia:
        platformUI = _androidHomePage(context);
        break;
    }
    return platformUI;
  }

  _buildAndroidNavigation(BuildContext context) {
    return BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            title: Text("Store"),
          ),
        ]);
  }

  _androidHomePage(BuildContext context) {
    appState = StateWidget.of(context).state;
    if (!appState.isLoading &&
        (appState.firebaseUserAuth == null ||
            appState.user == null ||
            appState.settings == null)) {
      return SignInScreen();
    } else {
      if (appState.isLoading) {
        _loadingVisible = true;
      } else {
        _loadingVisible = false;
      }
      return Scaffold(
          bottomNavigationBar: _buildAndroidNavigation(context),
          body: LoadingScreen(
            child: _pages[_currentIndex],
            inAsyncCall: _loadingVisible,
          ));
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  _iOSHomePage(BuildContext context) {
    appState = StateWidget.of(context).state;
    if (!appState.isLoading &&
        (appState.firebaseUserAuth == null ||
            appState.user == null ||
            appState.settings == null)) {
      return SignInScreen();
    } else {
      if (appState.isLoading) {
        _loadingVisible = true;
      } else {
        _loadingVisible = false;
      }
      return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
            inactiveColor: CupertinoColors.inactiveGray,
            activeColor: Colors.deepPurpleAccent,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.store),
                title: Text("Store"),
              ),
            ]),
        tabBuilder: (BuildContext context, int index) {
          assert(index >= 0 && index <= 3);
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (BuildContext context) => LogoutPage(),
                defaultTitle: "Home",
              );
              break;
            case 1:
              return CupertinoTabView(
                builder: (BuildContext context) => StorePage(),
                defaultTitle: "Store",
              );
              break;
          }
          return null;
        },
      );
    }
  }
}
