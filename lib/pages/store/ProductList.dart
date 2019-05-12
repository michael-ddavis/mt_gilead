import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/pages/store/ProductDetail.dart';
import 'package:mt_gilead/pages/store/widgets/product/ProductCardWidget.dart';
import 'package:mt_gilead/utils/UIData.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductListState();
  }
}

class ProductListState extends State<ProductList> {
  List selectedProductCards;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget platformUI;

    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
        return _androidProductListPage();
        break;
      case TargetPlatform.iOS:
        platformUI = _iOSProductListPage();
        break;
      case TargetPlatform.fuchsia:
        platformUI = _androidProductListPage();
        break;
    }
    return platformUI;
  }

  _storeNavigationBarAndroid() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 1.0,
      title: Text(
        'Products',
        style: baseToolbarStyle,
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.black,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          color: Colors.black,
          iconSize: 24.0,
          onPressed: () {},
        ),
      ],
    );
  }

  _storeNavigationBarIOS() {
    return CupertinoNavigationBar(
      backgroundColor: Colors.white70,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.search, color: CupertinoColors.black, size: 24.0),
        ],
      ),
      middle: Text(
        "Products",
        style: baseToolbarStyle,
      ),
    );
  }

  _sortAndFilterBar() {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: 56.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        CupertinoIcons.filter_outline,
                        size: 32.0,
                      )
                    ],
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Center _buildLoadingIndicator() {
    return Center(
      child: new CircularProgressIndicator(),
    );
  }

  _products() {
    CollectionReference collectionReference = Firestore.instance
        .collection('products')
        .document('sermons')
        .collection('sermon');
    Stream<QuerySnapshot> stream;
    stream = collectionReference.snapshots();
    return Expanded(
      child: new StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return _buildLoadingIndicator();
          return new GridView(
            scrollDirection: Axis.vertical,
            controller: ScrollController(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 8.0, crossAxisSpacing: 8.0),
            children: snapshot.data.documents.map((document) {
              return Material(
                  child: InkWell(
                      onTap: () {
                        if (Platform.isIOS) {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ProductDetail(
                                  product: Product.fromMap(
                                      document.data, document.documentID)),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                  product: Product.fromMap(
                                      document.data, document.documentID)),
                            ),
                          );
                        }
                      },
                      child: ProductCard(
                          product: Product.fromMap(
                              document.data, document.documentID))));
            }).toList(),
          );
        },
      ),
    );
  }

  _storeHomePage() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _sortAndFilterBar(),
          _products(),
        ],
      ),
    );
  }

  _androidProductListPage() {
    return Scaffold(
      appBar: _storeNavigationBarAndroid(),
      body: _storeHomePage(),
    );
  }

  _iOSProductListPage() {
    return CupertinoPageScaffold(
      navigationBar: _storeNavigationBarIOS(),
      child: _storeHomePage(),
    );
  }
}
