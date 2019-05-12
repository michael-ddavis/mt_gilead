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
        alignment: Alignment.bottomLeft,
        child: SizedBox(
          width: size,
          child: Container(
              height: 60.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: Text(product.title, style: productSermonTitleStyle),
                  ),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    height: 1,
                    width: 150.0,
                    color: Colors.amber,
                  ),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: Text(product.date, style: productSermonDateStyle),
                  ),
                ],
              )),
        ));
  }
}
