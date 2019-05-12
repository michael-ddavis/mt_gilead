import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Product.dart';
import 'package:mt_gilead/models/state.dart';
import 'package:mt_gilead/pages/store/widgets/ProductPriceAreaWidget.dart';
import 'package:mt_gilead/utils/Palatte.dart';
import 'package:mt_gilead/utils/UIData.dart';
import 'package:mt_gilead/utils/state_widget.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  ProductDetail({Key key, @required this.product}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState(product);
}

class _ProductDetailState extends State<ProductDetail> {
  Product product;
  StateModel appState;
  List favorites;

  _ProductDetailState(this.product);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget platformUI;

    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
        return _androidProductDetailPage();
        break;
      case TargetPlatform.iOS:
        platformUI = _iOSProductDetailPage();
        break;
      case TargetPlatform.fuchsia:
        platformUI = _androidProductDetailPage();
        break;
    }
    return platformUI;
  }

  ///////////////////////////Navigation/////////////////////////////////////////

  _productDetailNavigationBarAndroid() {
    return AppBar(
      backgroundColor: Palatte.white,
      centerTitle: true,
      title: Text(
        'Product Detail',
        style: baseTextStyle,
      ),
    );
  }

  _productDetailNavigationBarIOS() {
    return CupertinoNavigationBar(
      backgroundColor: Palatte.iOSWhite,
      middle: Text(
        "Product Detail",
        style: baseToolbarStyle,
      ),
    );
  }

  _buildDivider(Size screenSize) {
    return Column(
      children: <Widget>[
        Center(
          child: Container(
            alignment: Alignment.center,
            color: Colors.grey[600],
            width: screenSize.width - 50.0,
            height: 0.25,
          ),
        ),
      ],
    );
  }

  _buildProductImagesWidgets() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 350.0,
      width: screenWidth - 75.0,
      margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0, // has the effect of softening the shadow
              spreadRadius: .5, // has the effect of extending the shadow
              offset: Offset(
                2.0, // horizontal, move right 10
                2.0, // vertical, move down 10
              ),
            )
          ],
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(product.image),
            fit: BoxFit.cover,
          )),
    );
  }

  _buildProductTitleWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 16.0, top: 16.0),
          child: Text(
            widget.product.title,
            style: productTitleTextStyle,
          ),
        ),
      ],
    );
  }

  _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              widget.product.description,
              style: productDescTextStyle,
              textAlign: TextAlign.start,
            ))
      ],
    );
  }
  
  /*
   ///////////////////////////Related Products Section//////////////////////////
  */

//  _relatedProducts() {
//    return Column(
//      children: <Widget>[
//        Container(
//          padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
//          child: Text(
//            "Related Products",
//            style: productDescriptionTitleTextStyle,
//          ),
//        ),
//        makeProductList(),
//      ],
//    );
//  }

  // Related Product List
//  Container makeProductList() => Container(
//        height: 175.0,
//        padding: EdgeInsets.only(top: 4.0),
//        child: ScrollConfiguration(
//          behavior: ScrollBehavior(),
//          child: ListView.builder(
//            shrinkWrap: true,
//            scrollDirection: Axis.horizontal,
//            itemCount: productCards.length,
//            itemBuilder: (BuildContext context, int index) {
//              return InkWell(
//                child: RelatedProductCard(product: productCards[index]),
//                onTap: () {
//                  Navigator.push(
//                    context,
//                    CupertinoPageRoute(
//                      builder: (context) =>
//                          ProductDetail(product: productCards[index]),
//                    ),
//                  );
//                },
//              );
//            },
//          ),
//        ),
//      );

  _productDetailPage() {
    Size screenSize = MediaQuery.of(context).size;
    StateModel appState = StateWidget.of(context).state;
    return ListView(
      children: <Widget>[
        _buildProductImagesWidgets(),
        SizedBox(height: 24.0),
        _buildProductTitleWidget(),
        SizedBox(height: 24.0),
        _buildDescription(),
        SizedBox(height: 24.0),
        ProductPriceArea(product: product, appState: appState),
        SizedBox(height: 24.0),
        _buildDivider(screenSize),
        SizedBox(height: 24.0),
        //_relatedProducts(),
      ],
    );
  }

  _androidProductDetailPage() {
    return Scaffold(
      appBar: _productDetailNavigationBarAndroid(),
      body: _productDetailPage(),
    );
  }

  _iOSProductDetailPage() {
    return CupertinoPageScaffold(
      navigationBar: _productDetailNavigationBarIOS(),
      child: _productDetailPage(),
    );
  }
}
