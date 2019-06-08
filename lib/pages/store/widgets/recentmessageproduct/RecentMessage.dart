import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Message.dart';
import 'package:mt_gilead/pages/store/widgets/recentmessageproduct'
    '/RecentMessageImage.dart';
import 'package:mt_gilead/pages/store/widgets/recentmessageproduct/RecentMessageText.dart';
import 'package:mt_gilead/utils/Constants.dart';

class RecentMessageProduct extends StatelessWidget {
  final Message message;

  RecentMessageProduct({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > Constants.BREAKPOINT
        ? largeMessageCard()
        : smallMessageCard();
  }

  smallMessageCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child:
                RecentMessageProductImage(message: message, imageHeight: 125.0),
          ),
          Container(
            child: RecentMessageProductText(message: message),
          ),
        ],
      ),
    );
  }

  largeMessageCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child:
                RecentMessageProductImage(message: message, imageHeight: 150.0),
          ),
          Container(
            child: RecentMessageProductText(message: message),
          ),
        ],
      ),
    );
  }
}
