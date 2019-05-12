import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/pages/store/widgets/productsection/ProductSectionImage.dart';
import 'package:mt_gilead/pages/store/widgets/productsection/ProductSectionText.dart';

class ProductSectionCard extends StatelessWidget {
  final Product product;
  final double imageSize;
  final double size;

  ProductSectionCard({Key key, this.product, this.imageSize, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _productCard(product, imageSize, size);
  }

  _productCard(Product product, double imageSize, double sizeForTextWidget) {
    return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        elevation: 4,
        margin: EdgeInsets.only(left:8.0, right: 8.0),
        child: Stack(
          children: <Widget>[
            ProductSectionImage(product: product, imageSize: imageSize),
            ProductSectionText(product: product, size: sizeForTextWidget),
          ],
        )
    );
  }
}
