import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/pages/store/widgets/relatedproducts/RelatedProductImageWidget.dart';
import 'package:mt_gilead/pages/store/widgets/relatedproducts/RelatedProductTextWidget.dart';

class RelatedProductCard extends StatelessWidget {
  final Product product;

  RelatedProductCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 2,
        child: Stack(
          children: <Widget>[
            RelatedProductImage(product: product),
            RelatedProductText(product: product),
          ],
        ));
  }
}
