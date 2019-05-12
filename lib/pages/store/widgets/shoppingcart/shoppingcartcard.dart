import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
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
      height: 175.0,
      width: imageSize,
      child: Image(
        image: product.image as ImageProvider,
        fit: BoxFit.cover,
      ),
    );
  }

  _productText() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
          child: Text(
            product.title,
            style: shoppingCartCardTitle,
          ),
        ),
        Container(
          child: Text(
            product.date,
            style: shoppingCartCardDate,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Text(
            product.price,
            style: shoppingCartCardPrice,
          ),
        ),
      ],
    );
  }

  _productQuantity(BuildContext context) {
    return Container(
        height: 40.0,
        margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
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
                  height: 45.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0)),
                    color: Colors.deepPurple,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.remove, size: 24.0),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        numberOfItems++;
                      });
                    },
                  )),
            ),
            Flexible(
              flex: 3,
              child: Container(
                width: 100.0,
                height: 45.0,
                alignment: Alignment.center,
                child: Text(numberOfItems.toString(),
                    textAlign: TextAlign.center, style: shoppingCartCardPrice),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                  height: 45.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0)),
                    color: Colors.deepPurple,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add, size: 24.0),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        numberOfItems--;
                      });
                    },
                  )),
            ),
          ],
        ));
  }

  _productCard(Product product, double imageSize, BuildContext context) {
    return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        elevation: 2,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            _productImage(),
            _productText(),
            _productQuantity(context)
          ],
        ));
  }
}
