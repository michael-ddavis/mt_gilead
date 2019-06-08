import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Message.dart';
import 'package:mt_gilead/pages/store/widgets/messageproduct/MessageProductImage.dart';
import 'package:mt_gilead/pages/store/widgets/messageproduct/MessageProductText.dart';
import 'package:mt_gilead/utils/Constants.dart';
import 'package:mt_gilead/utils/UIData.dart';

class MessageProductCard extends StatelessWidget {
  final Message message;

  MessageProductCard({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > Constants.BREAKPOINT
        ? largeMessageCard()
        : smallMessageCard();
  }

  smallMessageCard() {
    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: MessageProductImage(message: message, imageHeight: 90.0),
        ),
        Container(
          child: MessageProductText(message: message),
        ),
        Container(
          child: Text(message.date, style: productSermonDateStyle),
        ),
      ],
    );
  }

  largeMessageCard() {
    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          child: MessageProductImage(message: message, imageHeight: 150.0),
        ),
        Container(
          child: MessageProductText(message: message),
        ),
        Container(
          child: Text(message.date, style: productSermonDateStyle),
        ),
      ],
    );
  }
}
