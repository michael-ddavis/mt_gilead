import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/pages/store/widgets/recentproduct/RecentProductImage.dart';
import 'package:mt_gilead/pages/store/widgets/recentproduct/RecentProductText'
    '.dart';

class RecentProduct extends StatelessWidget {
  final Product product;
  final double imageSize;
  final double size;

  RecentProduct({Key key, this.product, this.imageSize, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 400 ? largeMessageCard() : smallMessageCard();
  }

  smallMessageCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: RecentProductImage(product: product, imageSize: 125.0),
          ),
          Container(
            child: RecentProductText(product: product),
          ),
        ],
      ),
    );
  }

  largeMessageCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: RecentProductImage(product: product, imageSize: 150.0),
          ),
          Container(
            child: RecentProductText(product: product),
          ),
        ],
      ),
    );
  }
}
