import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Message.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/models/state.dart';
import 'package:mt_gilead/pages/store/MessageProductDetail.dart';
import 'package:mt_gilead/pages/store/ProductDetail.dart';
import 'package:mt_gilead/pages/store/widgets/messageproduct'
    '/MessageProductCard.dart';
import 'package:mt_gilead/pages/store/widgets/product/ProductCard.dart';
import 'package:mt_gilead/utils/Constants.dart';
import 'package:mt_gilead/utils/UIData.dart';

class FavoritesPage extends StatefulWidget {
  final StateModel appState;
  
  FavoritesPage({this.appState});
  
  @override
  State<StatefulWidget> createState() {
    return FavoritesPageState(appState);
  }
}

class FavoritesPageState extends State<FavoritesPage> {
  StateModel appState;
  Map<String, String> favorites;
  
  FavoritesPageState(this.appState);

  @override
  void initState() {
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

//////////////////////////////////Navigation////////////////////////////////////
  _storeNavigationBarAndroid() {
    return AppBar(
      backgroundColor: Colors.red[900],
      centerTitle: true,
      elevation: 1.0,
      title: Text(
        'Favorites',
        style: baseTextStyle,
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  _storeNavigationBarIOS() {
    return CupertinoNavigationBar(
      actionsForegroundColor: Colors.white,
      backgroundColor: Color(0xB3B71C1C),
      middle: Text(
        "Favorites",
        style: baseTextStyle,
      ),
    );
  }
  
  //////////////////////////////////Favorites///////////////////////////////////
  Center _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  
  _showFavorites() {
    Query query = Firestore.instance.collection(Constants.PRODUCTS).where(
        Constants.FAVORITES,
        arrayContains: appState.firebaseUserAuth.uid);
    Stream<QuerySnapshot> stream;
    stream = query.snapshots();
    return SafeArea(
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          StreamBuilder(
            stream: stream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return _buildLoadingIndicator();
              if (snapshot.data.documents.length < 1)
                return Container(
                  color: Color.fromARGB(255, 255, 250, 250),
                  alignment: Alignment.center,
                  child: Text("Nothing Here"),
                );
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return _buildLoadingIndicator();
                  break;
                default:
                  return GridView(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    scrollDirection: Axis.vertical,
                    controller: ScrollController(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 4.0),
                    children: snapshot.data.documents.map((document) {
                      return GestureDetector(
                          onTap: () {
                            if (Platform.isIOS) {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                  document.data['type'] ==
                                      Constants.MESSAGES
                                      ? MessageProductDetail(
                                      message: Message.fromMap(
                                          document.data,
                                          document.documentID))
                                      : ProductDetail(
                                      product: Product.fromMap(
                                          document.data,
                                          document.documentID)),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  document.data['type'] ==
                                      Constants.MESSAGES
                                      ? MessageProductDetail(
                                      message: Message.fromMap(
                                          document.data,
                                          document.documentID))
                                      : ProductDetail(
                                      product: Product.fromMap(
                                          document.data,
                                          document.documentID)),
                                ),
                              );
                            }
                          },
                          child: document.data['type'] == Constants.MESSAGES
                              ? MessageProductCard(
                              message: Message.fromMap(
                                  document.data, document.documentID))
                              : ProductCard(
                            product: Product.fromMap(
                                document.data, document.documentID),
                          ));
                    }).toList(),
                  );
              }
            },
          ),
        ],
      ),
    );
  }

  _androidFavoritesListPage() {
    return Scaffold(
      appBar: _storeNavigationBarAndroid(),
      body: _showFavorites(),
    );
  }

  _iOSFavoritesListPage() {
    return CupertinoPageScaffold(
      navigationBar: _storeNavigationBarIOS(),
      child: _showFavorites(),
    );
  }
}
