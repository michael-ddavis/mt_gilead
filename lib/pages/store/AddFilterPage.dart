import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/pages/store/ProductList.dart';
import 'package:mt_gilead/utils/UIData.dart';

class AddFilterPage extends StatefulWidget {
  final String productType;

  AddFilterPage({this.productType});

  @override
  State<StatefulWidget> createState() {
    return _AddFilterPageState(productType);
  }
}

class _AddFilterPageState extends State<AddFilterPage> {
  String productType;

  _AddFilterPageState(this.productType);

  @override
  Widget build(BuildContext context) {
    Widget platformUI;

    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
        return _androidFilterPage();
        break;
      case TargetPlatform.iOS:
        platformUI = _iOSFilterPage();
        break;
      case TargetPlatform.fuchsia:
        platformUI = _androidFilterPage();
        break;
    }
    return platformUI;
  }

  _filterPageNavBarAndroid() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 1.0,
      title: Text(
        "Filters",
        style: baseToolbarStyle,
      ),
      leading: IconButton(
        icon: Icon(Icons.close),
        color: Colors.black,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.check),
          color: Colors.black,
          iconSize: 24.0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductList(productType: productType)),
            );
          },
        ),
      ],
    );
  }

  _filterPageNavBarIOS() {
    return CupertinoNavigationBar(
      backgroundColor: Colors.white70,
      leading: GestureDetector(
        child: Icon(CupertinoIcons.clear_circled,
            color: CupertinoColors.black, size: 24.0),
        onTap: () {
          Navigator.popAndPushNamed(context, '/product_list',
              arguments: productType);
        },
      ),
      trailing: GestureDetector(
        child: Icon(CupertinoIcons.check_mark_circled,
            color: CupertinoColors.black, size: 24.0),
        onTap: () {
          Navigator.popAndPushNamed(context, '/product_list',
              arguments: productType);
        },
      ),
      middle: Text(
        "Filters",
        style: baseToolbarStyle,
      ),
    );
  }

  _filters() {
    return Container(child: Center(child: Text("Filter Page")));
  }

  _androidFilterPage() {
    return Scaffold(
      appBar: _filterPageNavBarAndroid(),
      body: _filters(),
    );
  }

  _iOSFilterPage() {
    return CupertinoPageScaffold(
      navigationBar: _filterPageNavBarIOS(),
      child: _filters(),
    );
  }
}
