import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel/flutter_carousel.dart';
import 'package:mt_gilead/models/Message.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/models/ProductCategory.dart';
import 'package:mt_gilead/models/state.dart';
import 'package:mt_gilead/pages/store/FavoritesPage.dart';
import 'package:mt_gilead/pages/store/MessageProductDetail.dart';
import 'package:mt_gilead/pages/store/ProductDetail.dart';
import 'package:mt_gilead/pages/store/ProductList.dart';
import 'package:mt_gilead/pages/store/ShoppingCartPage.dart';
import 'package:mt_gilead/pages/store/widgets/StoreCategoriesHeader.dart';
import 'package:mt_gilead/pages/store/widgets/productsection/ProductSectionCard.dart';
import 'package:mt_gilead/pages/store/widgets/recentmessageproduct'
    '/RecentMessage'
    '.dart';
import 'package:mt_gilead/pages/store/widgets/recentproduct/RecentProduct.dart';
import 'package:mt_gilead/utils/Constants.dart';
import 'package:mt_gilead/utils/Palatte.dart';
import 'package:mt_gilead/utils/UIData.dart';
import 'package:mt_gilead/utils/state_widget.dart';

class StorePage extends StatefulWidget {
  final StateModel appState;

  StorePage({this.appState});

  @override
  State<StatefulWidget> createState() {
    return StorePageState(appState);
  }
}

class StorePageState extends State<StorePage> {
  Iterable<String> bannerImages;
  StateModel appState;

  StorePageState(this.appState);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget platformUI;
    StateModel appState = StateWidget.of(context).state;

    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
        return _androidStorePage(appState);
        break;
      case TargetPlatform.iOS:
        platformUI = _iOSStorePage(appState);
        break;
      case TargetPlatform.fuchsia:
        platformUI = _androidStorePage(appState);
        break;
    }
    return platformUI;
  }

  ///////////////////////////Navigation/////////////////////////////////////////

  _storeNavigationBarAndroid(StateModel appState) {
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
              builder: (context) => ShoppingCartPage(appState: appState),
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
                builder: (context) => FavoritesPage(appState: appState),
              ),
            );
          },
        ),
      ],
    );
  }

  _storeNavigationBarIOS(StateModel appState) {
    return CupertinoNavigationBar(
      backgroundColor: Palatte.iOSPrimaryColor,
      leading: GestureDetector(
        child: Icon(CupertinoIcons.shopping_cart,
            color: CupertinoColors.white, size: 24.0),
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ShoppingCartPage(appState: appState),
            ),
          );
        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.search, color: CupertinoColors.white, size: 24.0),
          Material(
            type: MaterialType.transparency,
            child: IconButton(
              icon: Icon(CupertinoIcons.heart_outline),
              color: CupertinoColors.white,
              iconSize: 24.0,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => FavoritesPage(appState: appState),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      middle: Text(
        "Store",
        style: baseTextStyle,
      ),
    );
  }

  /////////////////////////////Store Products///////////////////////////////////

  Center _buildLoadingIndicator() {
    return Center(
      child: Platform.isAndroid
          ? CircularProgressIndicator()
          : CupertinoActivityIndicator(),
    );
  }

  _banner() {
    var height = (MediaQuery.of(context).size.height / 5) * 2;

    return Container(
      height: height,
      child: StreamBuilder<QuerySnapshot>(
        stream:
            Firestore.instance.collection(Constants.STORE_BANNER).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return _buildLoadingIndicator();
          if (snapshot.hasError)
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return _buildLoadingIndicator();
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
                      height: height,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: <Widget>[
                          _buildLoadingIndicator(),
                          Center(
                              child: FadeInImage.assetNetwork(
                                  placeholder: "assets/images/placeholder.png",
                                  image: bannerImages.elementAt(i)))
                        ],
                      ));
                }),
              );
              break;
          }
        },
      ),
    );
  }

  _recentProduct() {
    Query query = Firestore.instance.collection(Constants.PRODUCTS).limit(10);
    Stream<QuerySnapshot> stream;
    stream = query.snapshots();
    return Container(
      height: 225.0,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return _buildLoadingIndicator();
              break;
            default:
              return ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return GestureDetector(
                    child: document['type'] == Constants.MESSAGES
                        ? RecentMessageProduct(
                            message: Message.fromMap(
                                document.data, document.documentID))
                        : RecentProduct(
                            product: Product.fromMap(
                                document.data, document.documentID)),
                    onTap: () {
                      if (Platform.isIOS) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                _showProduct(document['type'], document),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                _showProduct(document['type'], document),
                          ),
                        );
                      }
                    },
                  );
                }).toList(),
              );
              break;
          }
        },
      ),
    );
  }

  _showProduct(String productType, DocumentSnapshot document) {
    switch (productType) {
      case Constants.MESSAGES:
        return MessageProductDetail(
            message: Message.fromMap(document.data, document.documentID),
            productType: Constants.MESSAGES);
        break;
      default:
        return ProductDetail(
            product: Product.fromMap(document.data, document.documentID));
        break;
    }
  }

  _productCategories() {
    CollectionReference collectionReference =
        Firestore.instance.collection(Constants.PRODUCT_CATEGORIES);
    Stream<QuerySnapshot> stream;
    stream = collectionReference.snapshots();
    return Container(
      height: 200.0,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return _buildLoadingIndicator();
              break;
            default:
              return ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return GestureDetector(
                    child: ProductSectionCard(
                        productCategory: ProductCategory.fromMap(
                            document.data, document.documentID)),
                    onTap: () {
                      if (Platform.isIOS) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                ProductList(productType: document.data['type']),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductList(productType: document.data['type']),
                          ),
                        );
                      }
                    },
                  );
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
        StoreCategoriesHeader(headerTitle: "Recent Products"),
        _recentProduct(),
        Container(
          padding: const EdgeInsets.fromLTRB(10.0, 8.0, 8.0, 4.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      "Categories",
                      style: productSectionHeaderStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _productCategories(),
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

  _androidStorePage(StateModel appState) {
    return Scaffold(
      appBar: _storeNavigationBarAndroid(appState),
      backgroundColor: Colors.white,
      body: _storeHomePage(),
    );
  }

  _iOSStorePage(StateModel appState) {
    return CupertinoPageScaffold(
      navigationBar: _storeNavigationBarIOS(appState),
      backgroundColor: CupertinoColors.white,
      child: _storeHomePage(),
    );
  }
}
