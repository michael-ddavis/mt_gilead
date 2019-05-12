import 'package:flutter/material.dart';

final baseTextStyle =
    const TextStyle(color: Colors.white, fontFamily: 'Roboto');

final baseToolbarStyle =
    const TextStyle(color: Colors.black, fontFamily: 'Roboto');

final productTitleTextStyle = baseTextStyle.copyWith(
    fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.black);

final shoppingCartCardTitle = baseTextStyle.copyWith(
    fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black);

final shoppingCartCardDate = baseTextStyle.copyWith(
    fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black);

final shoppingCartCardPrice = baseTextStyle.copyWith(
    fontSize: 24.0,
    fontWeight: FontWeight.w200,
    color: Colors.black,
    fontFamily: 'Trebuchet');

final productSubTitleTextStyle = baseTextStyle.copyWith(
    fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black);

final productDescriptionTitleTextStyle = baseTextStyle.copyWith(
    fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black);

final productSectionHeaderStyle = baseTextStyle.copyWith(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    letterSpacing: 1.5);

final productSectionViewAllStyle = baseTextStyle.copyWith(
    fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black);

final productLatestSermonTitleStyle = baseTextStyle.copyWith(fontSize: 24.0);

final productLatestSermonDateStyle =
    baseTextStyle.copyWith(fontSize: 14.0, fontWeight: FontWeight.w300);

final productSermonTitleStyle =
    baseTextStyle.copyWith(fontSize: 16.0, color: Colors.black);

final relatedProductTitle = baseTextStyle.copyWith(fontSize: 16.0);

final relatedProductDate = baseTextStyle.copyWith(
    fontSize: 16.0, fontWeight: FontWeight.w700, color: Colors.black);

final productSectionTitleStyle =
    baseTextStyle.copyWith(fontSize: 14.0, fontWeight: FontWeight.w700);

final tagStyle =
    baseTextStyle.copyWith(fontSize: 10.0, fontWeight: FontWeight.w400);

final productSermonDateStyle = baseTextStyle.copyWith(
    fontSize: 12.0, fontWeight: FontWeight.w300, color: Colors.black);

final productDescTextStyle = baseTextStyle.copyWith(
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    color: Colors.black54,
    height: 1.5);

// Allows for list item and the index to be put
// or (mapped) conveniently together.
List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

final List carouselImages = [
  'assets/images/i.jpg',
  'assets/images/j.jpg',
  'assets/images/l.jpg',
  'assets/images/k.jpg'
];

final List shoppingCartList = [];
final List favoritesList = [];



class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
