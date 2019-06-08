import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';

class RecentProductImage extends StatelessWidget {
  final Product product;
  final double imageSize;

  RecentProductImage({Key key, this.product, this.imageSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: imageSize,
        width: imageSize,
        child: Center(
            child: FadeInImage.assetNetwork(
                fit: BoxFit.fitHeight,
                placeholder: "assets/images/placeholder.png",
                image: product.image)));
  }
}
