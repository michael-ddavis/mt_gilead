import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';

class ProductImage extends StatelessWidget {
  final Product product;
  final double imageSize;

  ProductImage({Key key, this.product, this.imageSize}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 125.0,
      width: imageSize,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          image: DecorationImage(
            image: NetworkImage(product.image),
            fit: BoxFit.cover,
          )),
    );
  }
}