import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/utils/UIData.dart';

class CarouselImageBuilder {

  final List imageWidgetList = map<Widget>(
    carouselImages,
        (index, i) {
      return Container(
        margin: EdgeInsets.all(0.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
          child: Stack(children: <Widget>[
            Image.asset(i, fit: BoxFit.cover, height:325.0, width: 1000.0),
          ]),
        ),
      );
    },
  ).toList();


}