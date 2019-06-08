import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/utils/UIData.dart';

class RelatedProductText extends StatelessWidget {
  final Product product;

  RelatedProductText({Key key, this.product}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
          height: 25.0,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(product.title, style: relatedProductTitle, maxLines: 1,
                overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),
            ],
          )),
    );
  }
}