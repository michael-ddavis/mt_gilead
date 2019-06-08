import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Message.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/models/state.dart';
import 'package:mt_gilead/pages/store/CheckoutFlowPage.dart';
import 'package:mt_gilead/pages/store/MessageProductDetail.dart';
import 'package:mt_gilead/pages/store/ProductDetail.dart';
import 'package:mt_gilead/pages/store/widgets/shoppingcart/ShoppingCartCard.dart';
import 'package:mt_gilead/utils/Constants.dart';
import 'package:mt_gilead/utils/Palatte.dart';
import 'package:mt_gilead/utils/UIData.dart';

class ShoppingCartPage extends StatefulWidget {
  final StateModel appState;
  
  ShoppingCartPage({this.appState});
  
  @override
  ShoppingCartPageState createState() => ShoppingCartPageState(appState);
}

class ShoppingCartPageState extends State<ShoppingCartPage> {
  List shoppingCartItems;
  StateModel appState;

  ShoppingCartPageState(this.appState);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget platformUI;

    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
        return _androidCartPage(context);
        break;
      case TargetPlatform.iOS:
        platformUI = _iOSCartPage(context);
        break;
      case TargetPlatform.fuchsia:
        platformUI = _androidCartPage(context);
        break;
    }
    return platformUI;
  }

  _cartNavigationBarAndroid() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 2.0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.black,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        'Shopping Cart',
        style: baseToolbarStyle,
      ),
    );
  }

  _cartNavigationBarIOS() {
    return CupertinoNavigationBar(
      backgroundColor: Palatte.iOSWhite,
      middle: Text(
        "Shopping Cart",
        style: baseToolbarStyle,
      ),
    );
  }

  _androidCartPage(BuildContext context) {
    return Scaffold(
      appBar: _cartNavigationBarAndroid(),
      body: _shoppingCartPage(),
    );
  }

  _iOSCartPage(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: _cartNavigationBarIOS(),
      child: _shoppingCartPage(),
    );
  }

  Center _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildBottomNavigationBar() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 56.0,
      color: Colors.grey[200],
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Column(
              children: <Widget>[
                Text(
                  "Subtotal:",
                ),
                Text("\$230.99"),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                onPressed: () {
                  if (Platform.isIOS) {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => CheckoutFlowPage(),
                        fullscreenDialog: true,
                      ),
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CheckoutFlowPage(),
                        fullscreenDialog: true,
                      ),
                    );
                  }
                },
                color: Colors.amberAccent,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        "Checkout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _cartItemsList() {
    Query query = Firestore.instance.collection(Constants.PRODUCTS).where(
        Constants.SHOPPING_CART,
        arrayContains: appState.firebaseUserAuth.uid);
    Stream<QuerySnapshot> stream = query.snapshots();
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return _buildLoadingIndicator();
        if (snapshot.data == null)
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
            return Container(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView(
                  shrinkWrap: true,
                  padding:
                  EdgeInsets.only(left: 16.0, right: 16.0, bottom: 48.0),
                  scrollDirection: Axis.vertical,
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
                                        document.data, document.documentID))
                                    : ProductDetail(
                                    product: Product.fromMap(document.data,
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
                                        document.data, document.documentID))
                                    : ProductDetail(
                                    product: Product.fromMap(document.data,
                                        document.documentID)),
                              ),
                            );
                          }
                        },
                        child: ShoppingCartCard(
                            product: Product.fromMap(
                                document.data, document.documentID)));
                  }).toList(),
                ),
              ),
            );
        }
      },
    );
  }

  _shoppingCartPage() {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          _cartItemsList(),
          Positioned(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: _buildBottomNavigationBar()))
        ],
      ),
    );
  }
}
