import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/utils/UIData.dart';

class ProductDetailDescription extends StatelessWidget {
  final Product product;

  ProductDetailDescription({@required this.product});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 400.0
        ? largeProductDetailDescription()
        : smallProductDetailDescription();
  }

  smallProductDetailDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              product.description,
              style: messageDescriptionTextStyleSmall,
              textAlign: TextAlign.start,
            ))
      ],
    );
  }

  largeProductDetailDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              product.description,
              style: messageDescriptionTextStyleLarge,
              textAlign: TextAlign.start,
            ))
      ],
    );
  }
}
