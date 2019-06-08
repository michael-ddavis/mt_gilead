import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Message.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/pages/store/MessageProductDetail.dart';
import 'package:mt_gilead/pages/store/ProductDetail.dart';
import 'package:mt_gilead/pages/store/widgets/messageproduct/MessageProductCard.dart';
import 'package:mt_gilead/pages/store/widgets/product/ProductCard.dart';
import 'package:mt_gilead/utils/Constants.dart';
import 'package:mt_gilead/utils/UIData.dart';

class ProductList extends StatefulWidget {
  final String productType;
  
  ProductList({this.productType});
  
  @override
  State<StatefulWidget> createState() {
    return _ProductListState(productType);
  }
}

class _ProductListState extends State<ProductList> {
  String productType;
  Query query;
  
  _ProductListState(this.productType);

  @override
  void initState() {
    super.initState();
    _setQuery();
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
  
  _getNavigationBarTitle() {
    switch (productType) {
      case Constants.MESSAGES:
        return 'Messages';
        break;
      case Constants.BISHOP_PRODUCTS:
        return 'Bishop\'s Products';
        break;
      case Constants.COPASTOR_PRODUCTS:
        return 'CoP\'s Products';
        break;
      case Constants.MUSIC:
        return 'Music';
        break;
      default:
        return 'All Products';
        break;
    }
  }

  _storeNavigationBarAndroid() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 1.0,
      title: Text(
        _getNavigationBarTitle(),
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
        IconButton(
          icon: Icon(Icons.filter_list),
          color: Colors.black,
          iconSize: 24.0,
          onPressed: () {},
        ),
      ],
    );
  }

  _storeNavigationBarIOS() {
    return CupertinoNavigationBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.white70,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.search,
              color: CupertinoColors.black,
              size: MediaQuery
                  .of(context)
                  .size
                  .width > Constants.BREAKPOINT
                  ? 24.0
                  : 16.0),
          Icon(CupertinoIcons.filter_outline,
              color: CupertinoColors.black,
              size: MediaQuery
                  .of(context)
                  .size
                  .width > Constants.BREAKPOINT
                  ? 24.0
                  : 16.0),
        ],
      ),
      middle: Text(
        _getNavigationBarTitle(),
        style: baseToolbarStyle,
      ),
    );
  }

  Center _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _products() {
    Stream<QuerySnapshot> stream;
    stream = query.snapshots();
    return Expanded(
      child: StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return _buildLoadingIndicator();
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
                child: document['type'] == Constants.MESSAGES
                    ? MessageProductCard(
                    message:
                    Message.fromMap(document.data, document.documentID))
                    : ProductCard(
                    product: Product.fromMap(
                        document.data, document.documentID)),
                onTap: () {
                  if (Platform.isIOS) {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) =>
                            _showProduct(productType, document),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            _showProduct(productType, document),
                      ),
                    );
                  }
                },
              );
            }).toList(),
          );
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
  
  _setQuery() {
    switch (productType) {
      case Constants.MESSAGES:
        return query = Firestore.instance
            .collection(Constants.PRODUCTS)
            .where("type", isEqualTo: Constants.MESSAGES);
        break;
      case Constants.BISHOP_PRODUCTS:
        return query = Firestore.instance
            .collection(Constants.PRODUCTS)
            .where("type", isEqualTo: Constants.BISHOP_PRODUCTS);
        break;
      case Constants.COPASTOR_PRODUCTS:
        return query = Firestore.instance
            .collection(Constants.PRODUCTS)
            .where("type", isEqualTo: Constants.COPASTOR_PRODUCTS);
        break;
      case Constants.MUSIC:
        return query = Firestore.instance
            .collection(Constants.PRODUCTS)
            .where("type", isEqualTo: Constants.MUSIC);
        break;
      default:
        return query = Firestore.instance.collection(Constants.PRODUCTS);
        break;
    }
  }

  _storeHomePage() {
    return SafeArea(
      child: Column(
        children: <Widget>[
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