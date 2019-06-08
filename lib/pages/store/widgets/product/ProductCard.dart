import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/pages/store/widgets/product/ProductImage.dart';
import 'package:mt_gilead/pages/store/widgets/product/ProductText.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double imageSize;
  final double size;

  ProductCard({Key key, this.product, this.imageSize, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return screenWidth > 400 ? largeMessageCard() : smallMessageCard();
  }

  smallMessageCard() {
    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          child: ProductImage(product: product, imageHeight: 90.0),
        ),
        Container(
          child: ProductText(product: product),
        ),
      ],
    );
  }

  largeMessageCard() {
    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          child: ProductImage(product: product, imageHeight: 150.0),
        ),
        Container(
          child: ProductText(product: product),
        ),
      ],
    );
  }
}
