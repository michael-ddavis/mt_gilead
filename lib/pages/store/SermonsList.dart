//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:mt_gilead/models/Product.dart';
//import 'package:mt_gilead/pages/store/ProductDetail.dart';
//import 'package:mt_gilead/pages/store/widgets/LatestProductTagWidget.dart';
//import 'package:mt_gilead/pages/store/widgets/ProductCardWidget.dart';
//import 'package:mt_gilead/pages/store/widgets/LatestProductCardWidget.dart';
//import 'package:mt_gilead/pages/store/widgets/ProductImageWidget.dart';
//import 'package:mt_gilead/pages/store/widgets/LatestProductTextWidget.dart';
//import 'package:mt_gilead/utils/UIData.dart';
//
//class SermonsList extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    return SermonsListState();
//  }
//}
//
//class SermonsListState extends State<SermonsList> {
//  List selectedProductCards;
//  Product latestSermon;
//
//  @override
//  void initState() {
//    selectedProductCards = getAllProductCards();
//    latestSermon = selectedProductCards[0];
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final screenSize = MediaQuery.of(context).size;
//
//    return Scaffold(
//      body: CupertinoPageScaffold(
//          child: CustomScrollView(
//        slivers: <Widget>[
//          CupertinoSliverNavigationBar(
//            transitionBetweenRoutes: true,
//            largeTitle: Text("Sermons"),
//            trailing: Icon(Icons.tune),
//          ),
//          SliverList(
//              delegate: SliverChildBuilderDelegate(
//                (BuildContext context, int index) {
//                  return InkWell(
//                      child: LatestProductCard(
//                        product: latestSermon,
//                        imageSize: screenSize.width,
//                        childrenWidgetList: <Widget>[
//                          ProductImage(
//                              product: latestSermon,
//                              imageSize: screenSize.width),
//                          LatestProductText(
//                              product: selectedProductCards[index]),
//                          LatestProductTag(),
//                        ],
//                      ),
//                      onTap: () {
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                            builder: (context) =>
//                                ProductDetail(product: latestSermon),
//                          ),
//                        );
//                      });
//                },
//                childCount: 1,
//              ),
//            ),
//          SliverGrid(
//              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                crossAxisCount: 2,
//              ),
//              delegate: new SliverChildBuilderDelegate(
//                (BuildContext context, int index) {
//                  return InkWell(
//                      child: ProductCard(product: selectedProductCards[index]),
//                      onTap: () {
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                            builder: (context) => ProductDetail(
//                                product: selectedProductCards[index]),
//                          ),
//                        );
//                      });
//                },
//                childCount: selectedProductCards.length,
//              ),
//            ),
//        ],
//      )),
//    );
//  }
//}
