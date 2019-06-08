import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/utils/UIData.dart';

class RecentProductText extends StatelessWidget {
  final Product product;
  final double size;

  RecentProductText({Key key, this.product, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125.0,
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Text(
        product.title,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        style: productSermonTitleStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
