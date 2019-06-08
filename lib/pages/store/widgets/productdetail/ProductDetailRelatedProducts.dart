import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/pages/store/ProductDetail.dart';
import 'package:mt_gilead/pages/store/widgets/relatedproducts'
    '/RelatedProduct.dart';
import 'package:mt_gilead/utils/Constants.dart';
import 'package:mt_gilead/utils/UIData.dart';

class ProductDetailRelatedProducts extends StatelessWidget {
  final Product product;
  final String id;
  final String type;

  ProductDetailRelatedProducts({
    @required this.product,
    @required this.id,
    @required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return _relatedProductList();
  }

  _relatedProductList() {
    CollectionReference collectionReference = Firestore.instance
        .collection(type)
        .document(product.documentId)
        .collection(Constants.RELATED_PRODUCTS);
    Stream<QuerySnapshot> stream;
    stream = collectionReference.snapshots();
    return Container(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              "Related Products",
              style: productDescriptionTitleTextStyle,
            ),
          ),
          Container(
            height: 250.0,
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: Text("Loading..."));
                    break;
                  default:
                    return new ListView(
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
                                        ProductDetail(product: product)),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetail(product: product)),
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
          ),
        ],
      ),
    );
  }
}
