import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';

class RelatedProductImage extends StatelessWidget {
  final Product product;

  RelatedProductImage({Key key, this.product}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175.0,
      decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.luminosity),
            image: product.image as ImageProvider,
            fit: BoxFit.cover,
          )),
    );
  }
}