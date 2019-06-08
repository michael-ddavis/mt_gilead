import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';

class RelatedProductImage extends StatelessWidget {
  final Product product;

  RelatedProductImage({Key key, this.product}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150.0,
        width: 150.0,
        alignment: Alignment.center,
        child: FadeInImage.assetNetwork(
            fit: BoxFit.fitHeight,
            placeholder: "assets/images/placeholder.png",
            image: product.image));
  }
}