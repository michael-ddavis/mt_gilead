import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/models/state.dart';
import 'package:mt_gilead/pages/store/widgets/ProductPriceArea.dart';
import 'package:mt_gilead/pages/store/widgets/productdetail'
    '/ProductDetailDescription.dart';
import 'package:mt_gilead/pages/store/widgets/productdetail'
    '/ProductDetailImage.dart';
import 'package:mt_gilead/pages/store/widgets/productdetail'
    '/ProductDetailTitle.dart';
import 'package:mt_gilead/pages/store/widgets/relatedproducts/RelatedProduct.dart';
import 'package:mt_gilead/utils/Constants.dart';
import 'package:mt_gilead/utils/Palatte.dart';
import 'package:mt_gilead/utils/UIData.dart';
import 'package:mt_gilead/utils/state_widget.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  
  ProductDetail({Key key, @required this.product}) : super(key: key);
  
  @override
  _ProductDetailState createState() => _ProductDetailState(product);
}

class _ProductDetailState extends State<ProductDetail> {
  Product product;
  StateModel appState;
  List favorites;
  
  _ProductDetailState(this.product);
  
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    Widget platformUI;
    
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
        return _androidProductDetailPage();
        break;
      case TargetPlatform.iOS:
        platformUI = _iOSProductDetailPage();
        break;
      case TargetPlatform.fuchsia:
        platformUI = _androidProductDetailPage();
        break;
    }
    return platformUI;
  }
  
  ///////////////////////////Navigation/////////////////////////////////////////
  
  _productDetailNavigationBarAndroid() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 1.0,
      title: Text(
        product.title,
        style: baseToolbarStyle,
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
  
  _productDetailNavigationBarIOS() {
    return CupertinoNavigationBar(
      backgroundColor: Palatte.iOSWhite,
      middle: Text(
        product.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: baseToolbarStyle,
      ),
    );
  }
  
  _buildDivider(Size screenSize) {
    return Column(
      children: <Widget>[
        Center(
          child: Container(
            alignment: Alignment.center,
            color: Colors.grey[600],
            width: screenSize.width - 50.0,
            height: 0.25,
          ),
        ),
      ],
    );
  }
  
  /*
   ///////////////////////////Related Products Section//////////////////////////
  */
  
  Center _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  
  _relatedProducts() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: Text(
            "Related Products",
            style: productDescriptionTitleTextStyle,
          ),
        ),
        _makeProductList(),
      ],
    );
  }
  
  //Related Product List
  _makeProductList() {
    CollectionReference collectionReference = Firestore.instance
        .collection(Constants.PRODUCTS)
        .document(product.documentId)
        .collection(Constants.RELATED_PRODUCTS);
    Stream<QuerySnapshot> stream;
    stream = collectionReference.snapshots();
    return Container(
      height: 250.0,
      padding: EdgeInsets.only(top: 4.0),
      child: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: StreamBuilder<QuerySnapshot>(
            stream: stream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return _buildLoadingIndicator();
                  break;
                default:
                  return ListView(
                    shrinkWrap: true,
                    padding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                    controller: ScrollController(),
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return GestureDetector(
                        child: RelatedProduct(
                            product: Product.fromMap(
                                document.data, document.documentID)),
                        onTap: () {
                          if (Platform.isIOS) {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    ProductDetail(
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
                                    ProductDetail(
                                        product: Product.fromMap(
                                            document.data,
                                            document.documentID)),
                              ),
                            );
                          }
                        },
                      );
                    }).toList(),
                  );
                  break;
              }
            }),
      ),
    );
  }
  
  _productDetailPage() {
    Size screenSize = MediaQuery.of(context).size;
    StateModel appState = StateWidget.of(context).state;
    return ListView(
      children: <Widget>[
        ProductDetailImage(product: product),
        SizedBox(height: 24.0),
        ProductDetailTitle(product: product),
        SizedBox(height: 24.0),
        ProductDetailDescription(product: product),
        SizedBox(height: 24.0),
        ProductPriceArea(
            product: product, appState: appState, id: product.documentId),
        SizedBox(height: 24.0),
        _buildDivider(screenSize),
        SizedBox(height: 24.0),
        _relatedProducts(),
      ],
    );
  }
  
  _androidProductDetailPage() {
    return Scaffold(
      appBar: _productDetailNavigationBarAndroid(),
      body: _productDetailPage(),
    );
  }
  
  _iOSProductDetailPage() {
    return CupertinoPageScaffold(
      navigationBar: _productDetailNavigationBarIOS(),
      child: _productDetailPage(),
    );
  }
}
