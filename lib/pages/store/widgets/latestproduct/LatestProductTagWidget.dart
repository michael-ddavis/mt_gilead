import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/utils/UIData.dart' show tagStyle;

class LatestProductTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      alignment: Alignment.topRight,
      child: Container(
        height: 30.0,
        width: 100.0,
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.zero,
              topLeft: Radius.zero,
              topRight: Radius.circular(15.0),
              bottomLeft: Radius.circular(15.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Latest Sermon",
                textAlign: TextAlign.center,
                style: tagStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
