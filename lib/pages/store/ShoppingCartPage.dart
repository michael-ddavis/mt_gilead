import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/pages/store/ProductList.dart';
import 'package:mt_gilead/pages/store/widgets/shoppingcart/shoppingcartcard.dart';
import 'package:mt_gilead/utils/UIData.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  ShoppingCartPageState createState() => ShoppingCartPageState();
}

class ShoppingCartPageState extends State<ShoppingCartPage> {
  List shoppingCartItems;
  
  //TODO: Make this work the same as the favorite button. It should work the
  // same.

  @override
  void initState() {
    shoppingCartItems = shoppingCartList;
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
      elevation: 0.0,
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
      backgroundColor: Colors.white70,
      middle: Text(
        "Shopping Cart",
        style: baseToolbarStyle,
      ),
    );
  }

  _androidCartPage(BuildContext context) {
    return Scaffold(
      appBar: _cartNavigationBarAndroid(),
      body: _page(),
    );
  }

  _iOSCartPage(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: _cartNavigationBarIOS(),
      child: _page(),
    );
  }

  _page() {
    return shoppingCartItems.length > 0
        ? SafeArea(
            child: Container(
            color: Color.fromARGB(255, 255, 250, 250),
            child: Column(
              children: <Widget>[
                _cartItemsList(),
                _totalsArea(),
              ],
            ),
          ))
        : Container(
            color: Color.fromARGB(255, 255, 250, 250),
            alignment: Alignment.center,
            child: Text("Nothing Here"),
          );
  }

  _totalsArea() {
    return Column(
      children: <Widget>[
        Card(
          margin: EdgeInsets.all(16.0),
          elevation: 2,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("Subtotal:"),
                trailing: Text("\$230.99"),
              ),
              Divider(color: Colors.grey, indent: 8.0),
              ListTile(
                title: Text("Taxes:"),
                trailing: Text("\$2.99"),
              ),
              Divider(color: Colors.grey, indent: 8.0),
              ListTile(
                title: Text("Total:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text("\$233.99",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              )
            ],
          ),
        ),
        Container(
          height: 50.0,
          margin: EdgeInsets.all(16.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            onPressed: () {},
            color: Colors.amberAccent,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Checkout",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        letterSpacing: 2.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _cartItemsList() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
          height: 350.0,
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              scrollDirection: Axis.horizontal,
              itemCount: shoppingCartItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Material(
                  child: InkWell(
                    child: ShoppingCartCard(
                        product: shoppingCartItems[index],
                        imageSize: 250.0,
                        size: 200.0),
                    onTap: () {
                      if (Platform.isIOS) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ProductList(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductList(),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
