import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/pages/store/widgets/product/ProductImageWidget.dart';
import 'package:mt_gilead/utils/UIData.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double imageSize;
  final double size;

  ProductCard({Key key, this.product, this.imageSize, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _productCard();
  }

  _productCard() {
    return Column(
      children: <Widget>[
        _buildProductCard(),
        _buildProductInfo(),
      ],
    );
  }

  _buildProductCard() {
    return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        child: Stack(
          children: <Widget>[
            ProductImage(product: product, imageSize: imageSize),
          ],
        ));
  }

  _buildProductInfo() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(2.0),
          child: Text(product.title, style: productSermonTitleStyle),
        ),
        Container(
          padding: EdgeInsets.all(2.0),
          child: Text(product.date, style: productSermonDateStyle),
        ),
        Container(
          padding: EdgeInsets.all(2.0),
          child: Text(
            product.price,
            style: productSubTitleTextStyle,
          ),
        ),
      ],
    );
  }
}
