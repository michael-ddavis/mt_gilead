import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';

class ProductImage extends StatelessWidget {
  final Product product;
  final double imageHeight;

  ProductImage({Key key, this.product, this.imageHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: imageHeight,
        width: double.infinity,
        child: FadeInImage.assetNetwork(
            fit: BoxFit.fitHeight,
            placeholder: "assets/images/placeholder.png",
            image: product.image));
  }
}
