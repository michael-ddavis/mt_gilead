import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Message.dart';

class RecentMessageProductImage extends StatelessWidget {
  final Message message;
  final double imageHeight;

  RecentMessageProductImage({Key key, this.message, this.imageHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageHeight,
      width: imageHeight,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/mtgileadcd.png"),
        fit: BoxFit.fitHeight,
      )),
    );
  }
}
