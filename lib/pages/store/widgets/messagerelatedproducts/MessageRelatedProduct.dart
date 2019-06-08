import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Message.dart';
import 'package:mt_gilead/pages/store/widgets/messagerelatedproducts'
    '/MessageRelatedProductImage.dart';
import 'package:mt_gilead/pages/store/widgets/messagerelatedproducts'
    '/MessageRelatedProductText.dart';
import 'package:mt_gilead/utils/UIData.dart';

class MessageRelatedProduct extends StatelessWidget {
  final Message message;

  MessageRelatedProduct({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.black12,
      ),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: MessageRelatedProductImage(message: message),
          ),
          Container(
            child: MessageRelatedProductText(message: message),
          ),
          Container(
            child: Text(message.date, style: productSermonDateStyle),
          ),
        ],
      ),
    );
  }
}
