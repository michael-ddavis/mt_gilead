import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/models/Message.dart';
import 'package:mt_gilead/models/state.dart';
import 'package:mt_gilead/pages/store/widgets/MessagePriceArea.dart';
import 'package:mt_gilead/pages/store/widgets/messageproductdetail'
    '/MessageProductDetailDescription.dart';
import 'package:mt_gilead/pages/store/widgets/messageproductdetail'
    '/MessageProductDetailImage.dart';
import 'package:mt_gilead/pages/store/widgets/messageproductdetail'
    '/MessageProductDetailRelatedProducts.dart';
import 'package:mt_gilead/pages/store/widgets/messageproductdetail'
    '/MessageProductDetailTitle.dart';
import 'package:mt_gilead/utils/Palatte.dart';
import 'package:mt_gilead/utils/UIData.dart';
import 'package:mt_gilead/utils/state_widget.dart';

class MessageProductDetail extends StatefulWidget {
  final Message message;
  final String productType;

  MessageProductDetail({@required this.message, this.productType});

  @override
  _MessageProductDetailState createState() =>
      _MessageProductDetailState(message, productType);
}

class _MessageProductDetailState extends State<MessageProductDetail> {
  Message product;
  String productType;
  StateModel appState;
  List favorites;

  _MessageProductDetailState(this.product, this.productType);

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
        product.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: baseToolbarStyle,
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.black,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  _productDetailNavigationBarIOS() {
    return CupertinoNavigationBar(
      backgroundColor: Palatte.iOSWhite,
      middle: Text(
        product.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
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
            width: screenSize.width - 25.0,
            height: 0.25,
          ),
        ),
      ],
    );
  }

  /*
   ///////////////////////////Related Products Section//////////////////////////
  */
  _productDetailPage() {
    Size screenSize = MediaQuery.of(context).size;
    StateModel appState = StateWidget.of(context).state;
    return ListView(
      children: <Widget>[
        MessageProductDetailImage(),
        SizedBox(height: 24.0),
        MessageProductDetailTitle(message: product),
        SizedBox(height: 24.0),
        MessageProductDetailDescription(message: product),
        SizedBox(height: 24.0),
        MessagePriceArea(
            message: product,
            appState: appState,
            type: productType,
            id: product.documentId),
        SizedBox(height: 24.0),
        _buildDivider(screenSize),
        SizedBox(height: 24.0),
        MessageProductDetailRelatedProducts(
            message: product, type: productType, id: product.documentId),
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
