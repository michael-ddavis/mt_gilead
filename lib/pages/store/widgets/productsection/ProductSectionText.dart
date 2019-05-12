import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/utils/UIData.dart';

class ProductSectionText extends StatelessWidget {
  final Product product;
  final double size;

  ProductSectionText({Key key, this.product, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      margin: EdgeInsets.only(top: 100.0),
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                  product.title,
                  style: productSectionTitleStyle,
                ),
              ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8.0),
            alignment: Alignment.centerRight,
            child: Material(
              child: Icon(
                Icons.arrow_forward_ios,
                size: 24.0,
                color: Colors.white,
              ),
              type: MaterialType.transparency,
            ),
          ),
        ],
      ),
    );
  }
}
