import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageProductDetailImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 400.0
        ? largeMessageProductDetailImage()
        : smallMessageProductDetailImage();
  }

  smallMessageProductDetailImage() {
    return Container(
      height: 200.0,
      width: 200.0,
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/mtgileadcd.png"),
        fit: BoxFit.fitHeight,
      )),
    );
  }

  largeMessageProductDetailImage() {
    return Container(
      height: 300.0,
      width: 300.0,
      margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/mtgileadcd.png"),
        fit: BoxFit.fitHeight,
      )),
    );
  }
}
