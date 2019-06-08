import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/utils/UIData.dart';

class ProductDetailTitle extends StatelessWidget {
  final Product product;

  ProductDetailTitle({@required this.product});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 400.0
        ? largeProductDetailTitle()
        : smallProductDetailTitle();
  }

  smallProductDetailTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            product.title,
            style: messageTitleTextStyleSmall,
          ),
        ),
      ],
    );
  }

  largeProductDetailTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            product.title,
            style: messageTitleTextStyleLarge,
          ),
        ),
      ],
    );
  }
}
