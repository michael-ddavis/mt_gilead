import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/models/state.dart';
import 'package:mt_gilead/utils/Palatte.dart';

class ProductPriceArea extends StatefulWidget {
  final Product product;
  final StateModel appState;
  final bool favorite;

  ProductPriceArea({@required this.product, this.appState, this.favorite});

  @override
  State<StatefulWidget> createState() {
    return ProductPriceAreaState(product, appState);
  }
}

class ProductPriceAreaState extends State<ProductPriceArea> {
  Product product;
  bool _inFavorites = false;
  bool _inShoppingCart = false;
  List favorites;
  List shoppingCart;
  StateModel appState;

  @override
  void initState() {
    super.initState();
    _productInFavorites(product.id);
    _productInShoppingCart(product.id);
  }

  ProductPriceAreaState(this.product, this.appState);
  ////////////////////////////////Favorites////////////////////////////////////
  _productInFavorites(String id) {
    Firestore.instance
        .collection('users')
        .document(appState.firebaseUserAuth.uid)
        .get()
        .then((document) {
      favorites = document['favorites'];
      setState(() {
        if (favorites.contains(id)) {
          _inFavorites = true;
        } else {
          _inFavorites = false;
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
    Firestore.instance
        .collection('users')
        .document(appState.firebaseUserAuth.uid)
        .updateData({
      "favorites": FieldValue.arrayRemove([product.id])
    });
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      aroundPadding: EdgeInsets.all(4.0),
      borderRadius: 4.0,
      backgroundColor: Palatte.primaryColor,
      message: "Removed from favorites",
      icon: Icon(Icons.favorite_border),
      duration: Duration(seconds: 2),
    ).show(context);
  }

  _addToFavorites() {
    Firestore.instance
        .collection('users')
        .document(appState.firebaseUserAuth.uid)
        .updateData({
      "favorites": FieldValue.arrayUnion([product.id])
    });
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      aroundPadding: EdgeInsets.all(4.0),
      borderRadius: 4.0,
      backgroundColor: Palatte.primaryColor,
      message: "Added to favorites",
      icon: Icon(Icons.favorite),
      duration: Duration(seconds: 2),
    ).show(context);
  }
  ///////////////////////////////Shopping Cart/////////////////////////////////
  _productInShoppingCart(String id) {
    Firestore.instance
        .collection('users')
        .document(appState.firebaseUserAuth.uid)
        .get()
        .then((document) {
      shoppingCart = document['shoppingcart'];
      setState(() {
        if (shoppingCart.contains(id)) {
          _inShoppingCart = true;
        } else {
          _inShoppingCart = false;
        }
      });
    });
  }

  _toggleShoppingCart() async {
    setState(() {
      if (_inFavorites) {
        _inFavorites = false;
        _removeFromShoppingCart();
      } else {
        _inFavorites = true;
        _addToShoppingCart();
      }
    });
  }

  _addToShoppingCart() {
    Firestore.instance
        .collection('users')
        .document(appState.firebaseUserAuth.uid)
        .updateData({
      "shoppingcart": FieldValue.arrayUnion([product.id])
    });
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      aroundPadding: EdgeInsets.all(4.0),
      borderRadius: 4.0,
      backgroundColor: Palatte.primaryColor,
      message: "Added to Shopping Cart",
      icon: Icon(Icons.add_shopping_cart),
      duration: Duration(seconds: 2),
    ).show(context);
  }

  _removeFromShoppingCart() {
    Firestore.instance
        .collection('users')
        .document(appState.firebaseUserAuth.uid)
        .updateData({
      "shoppingcart": FieldValue.arrayRemove([product.id])
    });
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      aroundPadding: EdgeInsets.all(4.0),
      borderRadius: 4.0,
      backgroundColor: Palatte.primaryColor,
      message: "Removed from Shopping Cart",
      icon: Icon(Icons.remove_shopping_cart),
      duration: Duration(seconds: 2),
    ).show(context);
  }

  _buildPriceAreaWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 16.0),
                    child: Text(
                      "\$4.99",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
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
                color: Theme.of(context).iconTheme.color,
                size: 28.0,
              ),
              elevation: 2.0,
              fillColor: Theme.of(context).buttonColor,
              shape: CircleBorder(),
            ),
          ),
          Flexible(
            flex: 2,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
              // if the product is already in the shopping cart, set on
              // pressed to null, if not leave it as it is.
              onPressed: !_inShoppingCart
                  ? null
                  : () {
                      _toggleShoppingCart();
                    },
              color: Colors.purple,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "ADD TO CART",
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

  @override
  Widget build(BuildContext context) {
    return _buildPriceAreaWidget();
  }
}