import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/utils/UIData.dart';

class RecentProductsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecentProductListState();
  }
}

class RecentProductListState extends State<RecentProductsList> {
  List productCards;

  @override
  void initState() {
    //productCards = getLatestProductCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /**
     * Product Sections
     */
    Container makeProductSectionHeader() => Container(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 24.0, 4.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Latest Arrivals',
                    style: productSectionHeaderStyle,
                  ),
                ),
              ),
              InkWell(
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black54,
                ),
                onTap: () {
                },
              ),
            ],
          ),
        );

    // Product Cards
    Container makeProductImage(Product product) => Container(
          width: 250.0,
          decoration: BoxDecoration(
              image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.luminosity),
            image: product.image as ImageProvider,
            fit: BoxFit.cover,
          )),
        );

    Container makeProductText(Product product) => Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.bottomLeft,
          child: Container(
              height: 80.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(product.title, style: productSermonTitleStyle),
                  Container(
                    height: 1.0,
                    width: 100.0,
                    color: Colors.amber,
                  ),
                  Text(
                    product.date,
                    style: productSermonDateStyle,
                  ),
                ],
              )),
        );

    Card makeProductCard(Product product) => Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 2,
        child: Stack(
          children: <Widget>[
            makeProductImage(product),
            makeProductText(product),
          ],
        ));

    Container makeProductList() => Container(
          height: 200.0,
          padding: EdgeInsets.only(top: 4.0),
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: productCards.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: makeProductCard(productCards[index]),
                  onTap: () {
                  },
                );
              },
            ),
          ),
        );

    Column productSection() => Column(
          children: <Widget>[
            makeProductSectionHeader(),
            makeProductList(),
          ],
        );

    return productSection();
  }
}
