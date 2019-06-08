import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Message.dart';
import 'package:mt_gilead/utils/UIData.dart';

class MessageProductText extends StatelessWidget {
  final Message message;

  MessageProductText({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Text(
        message.title,
        maxLines: 2,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: productSermonTitleStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
