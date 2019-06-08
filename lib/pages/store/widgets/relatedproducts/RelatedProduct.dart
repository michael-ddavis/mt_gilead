import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/pages/store/widgets/relatedproducts'
    '/RelatedProductImage.dart';
import 'package:mt_gilead/pages/store/widgets/relatedproducts'
    '/RelatedProductText.dart';

class RelatedProduct extends StatelessWidget {
  final Product product;

  RelatedProduct({Key key, this.product}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.black12,
      ),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: RelatedProductImage(product: product),
          ),
          Container(
            child: RelatedProductText(product: product),
          ),
        ],
      ),
    );
  }
}
