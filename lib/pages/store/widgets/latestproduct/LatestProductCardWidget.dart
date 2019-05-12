import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/pages/store/widgets/latestproduct/LatestProductTagWidget.dart';
import 'package:mt_gilead/pages/store/widgets/latestproduct/LatestProductTextWidget.dart';
import 'package:mt_gilead/pages/store/widgets/product/ProductImageWidget.dart';

class LatestProductCard extends StatelessWidget {
  final Product product;
  final double imageSize;
  final List<Widget> childrenWidgetList;

  LatestProductCard(
      {Key key, this.product, this.imageSize, this.childrenWidgetList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _latestProductCard(product, imageSize, childrenWidgetList);
  }

  _latestProductCard(Product product, double imageSize, List<Widget> children) {
    List<Widget> childrenWidgets = children == null
        ? [
            ProductImage(product: product, imageSize: imageSize),
            LatestProductText(product: product),
            LatestProductTag()
          ]
        : children;

    return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        elevation: 0,
        child: Stack(
          children: childrenWidgets,
        ));
  }
}
