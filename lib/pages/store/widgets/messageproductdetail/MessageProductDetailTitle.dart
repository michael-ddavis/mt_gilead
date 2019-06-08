import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Message.dart';
import 'package:mt_gilead/utils/UIData.dart';

class MessageProductDetailTitle extends StatelessWidget {
  final Message message;

  MessageProductDetailTitle({@required this.message});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 400.0
        ? largeMessageProductDetailTitle()
        : smallMessageProductDetailTitle();
  }

  smallMessageProductDetailTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            message.title,
            style: messageTitleTextStyleSmall,
          ),
        ),
      ],
    );
  }

  largeMessageProductDetailTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            message.title,
            style: messageTitleTextStyleLarge,
          ),
        ),
      ],
    );
  }
}
