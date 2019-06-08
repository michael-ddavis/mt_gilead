import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Message.dart';
import 'package:mt_gilead/utils/UIData.dart';

class MessageProductDetailDescription extends StatelessWidget {
  final Message message;

  MessageProductDetailDescription({@required this.message});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 400.0
        ? largeMessageProductDetailDescription()
        : smallMessageProductDetailDescription();
  }

  smallMessageProductDetailDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              message.description,
              style: messageDescriptionTextStyleSmall,
              textAlign: TextAlign.start,
            ))
      ],
    );
  }

  largeMessageProductDetailDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              message.description,
              style: messageDescriptionTextStyleLarge,
              textAlign: TextAlign.start,
            ))
      ],
    );
  }
}
