import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel/flutter_carousel.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/pages/store/FavoritesPage.dart';
import 'package:mt_gilead/pages/store/ProductList.dart';
import 'package:mt_gilead/pages/store/ShoppingCartPage.dart';
import 'package:mt_gilead/pages/store/widgets/StoreCategoriesHeader.dart';
import 'package:mt_gilead/pages/store/widgets/productsection/ProductSectionCard.dart';
import 'package:mt_gilead/utils/Palatte.dart';
import 'package:mt_gilead/utils/UIData.dart';

class StorePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StorePageState();
  }
}

class StorePageState extends State<StorePage> {
  Iterable<String> bannerImages;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget platformUI;

    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
        return _androidStorePage();
        break;
      case TargetPlatform.iOS:
        platformUI = _iOSStorePage();
        break;
      case TargetPlatform.fuchsia:
        platformUI = _androidStorePage();
        break;
    }
    return platformUI;
  }

  ///////////////////////////Navigation/////////////////////////////////////////

  _storeNavigationBarAndroid() {
    return AppBar(
      backgroundColor: Palatte.primaryColor,
      leading: IconButton(
        icon: Icon(Icons.shopping_cart),
        color: Colors.white,
        iconSize: 24.0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShoppingCartPage(),
            ),
          );
        },
      ),
      centerTitle: true,
      title: Text(
        'Store',
        style: baseTextStyle,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          color: Colors.white,
          iconSize: 24.0,
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.favorite),
          color: Colors.white,
          iconSize: 24.0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoritesPage(),
              ),
            );
          },
        ),
      ],
    );
  }

  _storeNavigationBarIOS() {
    return CupertinoNavigationBar(
      backgroundColor: Palatte.iOSPrimaryColor,
      leading: GestureDetector(
        child: Icon(CupertinoIcons.shopping_cart,
            color: CupertinoColors.black, size: 24.0),
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ShoppingCartPage(),
            ),
          );
        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.search, color: CupertinoColors.black, size: 24.0),
          Material(
            type: MaterialType.transparency,
            child: IconButton(
              icon: Icon(CupertinoIcons.heart_outline),
              color: CupertinoColors.black,
              iconSize: 24.0,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => FavoritesPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      middle: Text(
        "Store",
        style: baseToolbarStyle,
      ),
    );
  }

  /////////////////////////////Store Products///////////////////////////////////

  Center _buildLoadingIndicator() {
    return Center(
      child: new CircularProgressIndicator(),
    );
  }

  _banner() {
    return Container(
      height: 300.0,
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('products')
            .document('banners')
            .collection('banner')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Text('No Data Available'),
            );
          if (snapshot.hasError)
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Text('Loading...'),
              );
              break;
            default:
              bannerImages = snapshot.data.documents
                  .map((document) => (document['image'].toString()));

              return Carousel(
                animationCurve: Curves.ease,
                animationDuration: const Duration(milliseconds: 200),
                displayDuration: const Duration(seconds: 3),
                children: List<Widget>.generate(bannerImages.length, (i) {
                  return Container(
                    height: 300.0,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(bannerImages.elementAt(i),
                        fit: BoxFit.cover),
                  );
                }),
              );
          }
        },
      ),
    );
  }

  _productCategories() {
    CollectionReference collectionReference = Firestore.instance
        .collection('products')
        .document('categories')
        .collection('category');
    Stream<QuerySnapshot> stream;
    stream = collectionReference.snapshots();
    return Container(
      height: 200.0,
      padding: EdgeInsets.all(8.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return _buildLoadingIndicator();
              break;
            default:
              return new ListView(
                shrinkWrap: true,
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Material(
                      child: InkWell(
                    child: ProductSectionCard(
                        product: Product.fromMap(
                            document.data, document.documentID)),
                    onTap: () {
                      if (Platform.isIOS) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ProductList(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductList(),
                          ),
                        );
                      }
                    },
                  ));
                }).toList(),
              );
              break;
          }
        },
      ),
    );
  }

  _storeCategories() {
    return Column(
      children: <Widget>[
        StoreCategoriesHeader(headerTitle: "What's new"),
        _productCategories(),
        //_storeOtherCategory(),
      ],
    );
  }

  _storeHomePage() {
    return ListView(
      children: <Widget>[
        _banner(),
        _storeCategories(),
      ],
    );
  }

  _androidStorePage() {
    return Scaffold(
      appBar: _storeNavigationBarAndroid(),
      body: _storeHomePage(),
    );
  }

  _iOSStorePage() {
    return CupertinoPageScaffold(
      navigationBar: _storeNavigationBarIOS(),
      child: _storeHomePage(),
    );
  }
}
