import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/utils/UIData.dart'
    show productLatestSermonTitleStyle, productLatestSermonDateStyle;

class LatestProductText extends StatelessWidget {
  final Product product;

  LatestProductText({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250.0,
        margin: EdgeInsets.only(top: 100.0),
        alignment: Alignment.bottomLeft,
        child: SizedBox(
          width: double.infinity,
          child: Container(
              height: 80.0,
              color: Colors.black.withOpacity(0.6),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(product.title,
                        style: productLatestSermonTitleStyle),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    height: 1,
                    width: 200.0,
                    color: Colors.amber,
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child:
                        Text(product.date, style: productLatestSermonDateStyle),
                  ),
                ],
              )),
        ));
  }
}
