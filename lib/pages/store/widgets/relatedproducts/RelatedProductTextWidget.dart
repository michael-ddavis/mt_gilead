import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/utils/UIData.dart';

class RelatedProductText extends StatelessWidget {
  final Product product;

  RelatedProductText({Key key, this.product}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.bottomLeft,
      child: Container(
          height: 80.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(product.title, style: relatedProductTitle),
              Container(
                height: 1.0,
                width: 100.0,
                color: Colors.amber,
              ),
              Text(
                product.date,
                style: relatedProductDate,
              ),
            ],
          )),
    );
  }
}