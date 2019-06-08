import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/ProductCategory.dart';
import 'package:mt_gilead/utils/UIData.dart';

class ProductSectionText extends StatelessWidget {
  final ProductCategory product;
  final double size;

  ProductSectionText({Key key, this.product, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      margin: EdgeInsets.only(top: 100.0),
      padding: EdgeInsets.only(left: 24.0),
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
            margin: EdgeInsets.only(left: 4.0),
            alignment: Alignment.centerRight,
            child: Material(
              child: Icon(
                Icons.arrow_forward_ios,
                size: 18.0,
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
