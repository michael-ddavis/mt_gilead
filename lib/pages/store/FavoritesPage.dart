import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/pages/store/ProductDetail.dart';
import 'package:mt_gilead/pages/store/widgets/product/ProductCardWidget.dart';
import 'package:mt_gilead/utils/UIData.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FavoritesPageState();
  }
}

class FavoritesPageState extends State<FavoritesPage> {
  List favorites;

  @override
  void initState() {
    favorites = favoritesList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget platformUI;

    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
        return _androidFavoritesListPage();
        break;
      case TargetPlatform.iOS:
        platformUI = _iOSFavoritesListPage();
        break;
      case TargetPlatform.fuchsia:
        platformUI = _androidFavoritesListPage();
        break;
    }
    return platformUI;
  }

  _storeNavigationBarAndroid() {
    return AppBar(
      backgroundColor: Colors.red,
      centerTitle: true,
      elevation: 1.0,
      title: Text(
        'Favorites',
        style: baseTextStyle,
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.black,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  _storeNavigationBarIOS() {
    return CupertinoNavigationBar(
      backgroundColor: Color(0xB3FF0000),
      middle: Text(
        "Favorites",
        style: baseTextStyle,
      ),
    );
  }

  _productGridView() {
    return Expanded(
      child: GridView(
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 8.0, crossAxisSpacing: 8.0),
        children: List.generate(favorites.length, (index) {
          return Material(
            child: InkWell(
              child: ProductCard(product: favorites[index]),
              onTap: () {
                if (Platform.isIOS) {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          ProductDetail(product: favorites[index]),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetail(product: favorites[index]),
                    ),
                  );
                }
              },
            ),
          );
        }),
      ),
    );
  }

  _favoritesPage() {
    return favorites.length > 0
        ? SafeArea(
            child: Column(
              children: <Widget>[
                _productGridView(),
              ],
            ),
          )
        : Container(
            color: Color.fromARGB(255, 255, 250, 250),
            alignment: Alignment.center,
            child: Text("Nothing Here"),
          );
  }

  _androidFavoritesListPage() {
    return Scaffold(
      appBar: _storeNavigationBarAndroid(),
      body: _favoritesPage(),
    );
  }

  _iOSFavoritesListPage() {
    return CupertinoPageScaffold(
      navigationBar: _storeNavigationBarIOS(),
      child: _favoritesPage(),
    );
  }
}
