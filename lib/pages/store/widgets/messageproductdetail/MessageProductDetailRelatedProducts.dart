import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Message.dart';
import 'package:mt_gilead/pages/store/MessageProductDetail.dart';
import 'package:mt_gilead/pages/store/widgets/messagerelatedproducts'
    '/MessageRelatedProduct.dart';
import 'package:mt_gilead/utils/Constants.dart';
import 'package:mt_gilead/utils/UIData.dart';

class MessageProductDetailRelatedProducts extends StatelessWidget {
  final Message message;
  final String id;
  final String type;

  MessageProductDetailRelatedProducts({
    @required this.message,
    @required this.id,
    @required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return _relatedProductList();
  }

  _relatedProductList() {
    CollectionReference collectionReference = Firestore.instance
        .collection(Constants.PRODUCTS)
        .document(message.documentId)
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
              "Related Messages",
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
                  case ConnectionState.done:
                    if (!snapshot.hasData)
                      return Container(
                          child: Center(
                              child: Text("No Recent "
                                  "Products")),
                          height: 200.0,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(8.0));
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
                          child: MessageRelatedProduct(
                              message: Message.fromMap(
                                  document.data, document.documentID)),
                          onTap: () {
                            if (Platform.isIOS) {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => MessageProductDetail(
                                        message: Message.fromMap(
                                            document.data, document.documentID),
                                        productType: type)),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MessageProductDetail(
                                        message: Message.fromMap(
                                            document.data, document.documentID),
                                        productType: type)),
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
