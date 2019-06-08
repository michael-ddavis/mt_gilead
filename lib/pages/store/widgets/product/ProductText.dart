import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/utils/UIData.dart';

class ProductText extends StatelessWidget {
  final Product product;
  final double size;

  ProductText({Key key, this.product, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
          height: 25.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(product.title, style: relatedProductTitle, maxLines: 1,
                overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),
            ],
          )),
    );
  }
}
