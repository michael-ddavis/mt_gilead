import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Message.dart';

class MessageRelatedProductImage extends StatelessWidget {
  final Message message;

  MessageRelatedProductImage({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 150.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/mtgileadcd.png"),
        fit: BoxFit.fitHeight,
      )),
    );
  }
}
