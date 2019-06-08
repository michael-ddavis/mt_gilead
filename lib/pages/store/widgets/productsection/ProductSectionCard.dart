import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/ProductCategory.dart';
import 'package:mt_gilead/pages/store/widgets/productsection/ProductSectionImage.dart';
import 'package:mt_gilead/pages/store/widgets/productsection/ProductSectionText.dart';

class ProductSectionCard extends StatelessWidget {
  final ProductCategory productCategory;
  final double imageSize;
  final double size;
  
  ProductSectionCard({Key key, this.productCategory, this.imageSize, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _productCard(productCategory, imageSize, size);
  }
  
  _productCard(ProductCategory productCategory, double imageSize,
      double sizeForTextWidget) {
    return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        elevation: 0,
        margin: EdgeInsets.only(left: 8.0, right: 8.0),
        child: Stack(
          children: <Widget>[
            ProductSectionImage(
                productCategory: productCategory, imageSize: imageSize),
            ProductSectionText(
                product: productCategory, size: sizeForTextWidget),
          ],
        ));
  }
}
