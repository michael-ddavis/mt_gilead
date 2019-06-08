import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Message.dart';

class MessageProductImage extends StatelessWidget {
  final Message message;
  final double imageHeight;

  MessageProductImage({Key key, this.message, this.imageHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageHeight,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/mtgileadcd.png"),
        fit: BoxFit.fitHeight,
      )),
    );
  }
}
