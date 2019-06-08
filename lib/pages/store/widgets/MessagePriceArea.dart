import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Message.dart';
import 'package:mt_gilead/models/state.dart';
import 'package:mt_gilead/utils/Constants.dart';
import 'package:mt_gilead/utils/Palatte.dart';

class MessagePriceArea extends StatefulWidget {
  final Message message;
  final String id;
  final String type;
  final StateModel appState;

  MessagePriceArea({@required this.message, this.id, this.type, this.appState});

  @override
  State<StatefulWidget> createState() {
    return MessagePriceAreaState(message, id, type, appState);
  }
}

class MessagePriceAreaState extends State<MessagePriceArea> {
  Message message;
  bool _inFavorites = false;
  bool _inShoppingCart = false;
  List favorites;
  List shoppingCart;
  StateModel appState;
  String type;
  String id;
  Firestore db;
  var ref;

  @override
  void initState() {
    super.initState();
    db = Firestore.instance;
    ref = db.collection(Constants.PRODUCTS).document(message.documentId);
    _productInFavorites();
    _productInShoppingCart();
  }

  MessagePriceAreaState(this.message, this.id, this.type, this.appState);

  ////////////////////////////////Favorites////////////////////////////////////
  _productInFavorites() {
    ref.get().then((document) {
      favorites = document[Constants.FAVORITES];
      setState(() {
        if (favorites != null) {
          if (favorites.contains(appState.firebaseUserAuth.uid)) {
            _inFavorites = true;
          } else {
            _inFavorites = false;
          }
        }
      });
    });
  }

  _toggleFavorites() async {
    setState(() {
      if (_inFavorites) {
        _inFavorites = false;
        _removeFromFavorites();
      } else {
        _inFavorites = true;
        _addToFavorites();
      }
    });
  }

  _removeFromFavorites() {
    WriteBatch batch = db.batch();

    batch.updateData(ref, {
      Constants.FAVORITES:
          FieldValue.arrayRemove([appState.firebaseUserAuth.uid])
    });

    batch.commit();
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      borderRadius: 2.0,
      backgroundColor: Palatte.secondaryColor,
      message: "Removed from favorites",
      duration: Duration(seconds: 2),
    ).show(context);
  }

  _addToFavorites() {
    WriteBatch batch = db.batch();

    batch.updateData(ref, {
      Constants.FAVORITES:
          FieldValue.arrayUnion([appState.firebaseUserAuth.uid])
    });

    batch.commit();
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      borderRadius: 2.0,
      backgroundColor: Palatte.secondaryColor,
      message: "Added to favorites",
      duration: Duration(seconds: 2),
    ).show(context);
  }

  ///////////////////////////////Shopping Cart/////////////////////////////////
  _productInShoppingCart() {
    ref.get().then((document) {
      shoppingCart = document[Constants.SHOPPING_CART];
      setState(() {
        if (shoppingCart != null) {
          if (shoppingCart.contains(appState.firebaseUserAuth.uid)) {
            _inShoppingCart = true;
          } else {
            _inShoppingCart = false;
          }
        }
      });
    });
  }

  _toggleShoppingCart() async {
    setState(() {
      if (_inShoppingCart) {
        _inShoppingCart = false;
        _removeFromShoppingCart();
      } else {
        _inShoppingCart = true;
        _addToShoppingCart();
      }
    });
  }

  _addToShoppingCart() {
    db.collection(Constants.PRODUCTS).document(message.documentId).updateData({
      Constants.SHOPPING_CART:
          FieldValue.arrayUnion([appState.firebaseUserAuth.uid])
    });

    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      borderRadius: 2.0,
      backgroundColor: Palatte.secondaryColor,
      leftBarIndicatorColor: Palatte.primaryColor,
      message: "Added to Shopping Cart",
      duration: Duration(seconds: 2),
    ).show(context);
  }

  _removeFromShoppingCart() {
    db.collection(Constants.PRODUCTS).document(message.documentId).updateData({
      Constants.SHOPPING_CART:
          FieldValue.arrayRemove([appState.firebaseUserAuth.uid])
    });

    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      borderRadius: 2.0,
      backgroundColor: Palatte.secondaryColor,
      message: "Removed from Shopping Cart",
      duration: Duration(seconds: 2),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: screenWidth > Constants.BREAKPOINT ? 50.0 : 40.0,
      margin: screenWidth > Constants.BREAKPOINT
          ? EdgeInsets.symmetric(horizontal: 16.0)
          : EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
              flex: screenWidth > Constants.BREAKPOINT ? 1 : 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 12.0, left: 16.0),
                    child: Text(
                      message.price,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize:
                              screenWidth > Constants.BREAKPOINT ? 22 : 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )),
          Flexible(
            flex: 1,
            child: RawMaterialButton(
              constraints:
                  const BoxConstraints(minWidth: 50.0, minHeight: 50.0),
              onPressed: () => _toggleFavorites(),
              child: Icon(
                _inFavorites ? Icons.favorite : Icons.favorite_border,
                color: Colors.amber[700],
                size: screenWidth > Constants.BREAKPOINT ? 28.0 : 24.0,
              ),
              elevation: 2.0,
              fillColor: Colors.white,
              shape: CircleBorder(),
            ),
          ),
          Flexible(
            flex: 2,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
              onPressed: _inShoppingCart
                  ? null
                  : () {
                      _toggleShoppingCart();
                    },
              color: Colors.purple,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _inShoppingCart
                        ? Text(
                            "ADDED",
                            style: TextStyle(color: Colors.white),
                          )
                        : Text(
                            "ADD",
                            style: TextStyle(color: Colors.white),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
