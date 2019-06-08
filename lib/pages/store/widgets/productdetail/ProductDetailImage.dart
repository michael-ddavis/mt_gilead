import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';

class ProductDetailImage extends StatelessWidget {
  final Product product;

  ProductDetailImage({@required this.product});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 400.0
        ? largeProductDetailImage()
        : smallProductDetailImage();
  }

  smallProductDetailImage() {
    return Container(
        height: 200.0,
        width: 200.0,
        margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: FadeInImage.assetNetwork(
            fit: BoxFit.fitHeight,
            placeholder: "assets/images/placeholder.png",
            image: product.image));
  }

  largeProductDetailImage() {
    return Container(
        height: 300.0,
        width: 300.0,
        margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
        child: FadeInImage.assetNetwork(
            fit: BoxFit.fitHeight,
            placeholder: "assets/images/placeholder.png",
            image: product.image));
  }
}
