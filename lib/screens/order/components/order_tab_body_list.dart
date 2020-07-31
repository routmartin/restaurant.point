import 'package:flutter/material.dart';

import 'sub_category_list.dart';

class OrderTabBodyList extends StatelessWidget {
  final String tabTitle;
  const OrderTabBodyList({
    Key key,
    this.tabTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Text(
              tabTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                fontFamily: 'San-francisco',
              ),
            ),
          ),
          SubCategoryList(),
        ],
      ),
    );
  }
}
