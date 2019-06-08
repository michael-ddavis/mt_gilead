import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/utils/Palatte.dart';
import 'package:mt_gilead/utils/UIData.dart';

class ShoppingCartCard extends StatefulWidget {
  final Product product;
  final double imageSize;
  final double size;

  ShoppingCartCard({Key key, this.product, this.imageSize, this.size})
      : super(key: key);

  @override
  ShoppingCartCardState createState() =>
      ShoppingCartCardState(product: product, imageSize: imageSize, size: size);
}

class ShoppingCartCardState extends State<ShoppingCartCard> {
  final Product product;
  final double imageSize;
  final double size;
  int numberOfItems = 1;

  ShoppingCartCardState({Key key, this.product, this.imageSize, this.size});

  @override
  Widget build(BuildContext context) {
    return _productCard(product, imageSize, context);
  }

  _productImage() {
    return Container(
      height: 100.0,
      width: 100.0,
      child: product.image == null
          ? Image(
          image: AssetImage("assets/images/mtgileadcd.png"),
          fit: BoxFit.fitHeight)
          : FadeInImage.assetNetwork(
          fit: BoxFit.fitHeight,
          placeholder: "assets/images/placeholder.png",
          image: product.image),
    );
  }

  _productTitle() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        product.title,
        style: shoppingCartCardTitle,
        textAlign: TextAlign.left,
      ),
    );
  }

  _productPrice() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Text(
        product.price,
        style: shoppingCartCardPrice,
      ),
    );
  }

  _productQuantity(BuildContext context) {
    return Container(
      height: 30.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
              flex: 1,
              child: Container(
                  width: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0)),
                    color: Colors.deepPurple,
                  ),
                  child: Material(
                      type: MaterialType.transparency,
                      child: IconButton(
                        icon:
                        Icon(Icons.remove, size: 14.0, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            if (numberOfItems != 0) numberOfItems--;
                          });
                        },
                      )))),
          Flexible(
            flex: 3,
            child: Container(
              width: 30.0,
              height: 20.0,
              alignment: Alignment.center,
              child: Text(numberOfItems.toString(),
                  textAlign: TextAlign.center, style: shoppingCartCardQuantity),
            ),
          ),
          Flexible(
              flex: 1,
              child: Container(
                  width: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0)),
                    color: Colors.deepPurple,
                  ),
                  child: Material(
                      type: MaterialType.transparency,
                      child: IconButton(
                        icon: Icon(Icons.add, size: 14.0, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            if (numberOfItems < 20) numberOfItems++;
                          });
                        },
                      )))),
        ],
      ),
    );
  }

  _productDelete() {
    return Material(
        color: Colors.transparent,
        child: IconButton(
          icon: Icon(
            CupertinoIcons.clear_circled_solid,
            color: Colors.black,
          ),
          onPressed: () {},
        ));
  }

  _buildDivider() {
    return Column(
      children: <Widget>[
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 16.0),
            alignment: Alignment.center,
            color: Colors.grey[600],
            width: MediaQuery
                .of(context)
                .size
                .width - 50.0,
            height: 0.25,
          ),
        ),
      ],
    );
  }

  _productCard(Product product, double imageSize, BuildContext context) {
    return Container(
      color: Palatte.white,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          Container(
              color: Palatte.white,
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: _productImage(),
                  ),
                  Flexible(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _productTitle(),
                        Row(children: <Widget>[
                          _productPrice(),
                          _productQuantity(context)
                        ]),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: _productDelete(),
                  )
                ],
              )),
          _buildDivider()
        ],
      ),
    );
  }
}
