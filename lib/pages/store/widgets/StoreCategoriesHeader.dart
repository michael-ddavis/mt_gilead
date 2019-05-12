import 'package:flutter/material.dart';
import 'package:mt_gilead/utils/UIData.dart';

class StoreCategoriesHeader extends StatelessWidget {
  final String headerTitle;

  StoreCategoriesHeader({this.headerTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(36.0, 8.0, 8.0, 4.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  headerTitle,
                  style: productSectionHeaderStyle,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
                'View All',
                style: productSectionViewAllStyle,
              ),
            ),
          Material(
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              iconSize: 12.0,
              color: Colors.orange,
              onPressed: () {},
            ),
            type: MaterialType.transparency,
          ),
        ],
      ),
    );
  }
}
