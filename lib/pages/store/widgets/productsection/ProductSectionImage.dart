import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';

class ProductSectionImage extends StatelessWidget {
  final Product product;
  final double imageSize;

  ProductSectionImage({Key key, this.product, this.imageSize}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      width: 190.0,
      child: Image(
        image: NetworkImage(product.image),
        fit: BoxFit.cover,
      ),
    );
  }
}