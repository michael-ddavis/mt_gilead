import 'package:flutter/material.dart';
import 'package:mt_gilead/models/ProductCategory.dart';

class ProductSectionImage extends StatelessWidget {
  final ProductCategory productCategory;
  final double imageSize;
  
  ProductSectionImage({Key key, this.productCategory, this.imageSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250.0,
        width: 200.0,
        child: FadeInImage.assetNetwork(
            fit: BoxFit.fitHeight,
            placeholder: "assets/images/placeholder.png",
            image: productCategory.image));
  }
}
