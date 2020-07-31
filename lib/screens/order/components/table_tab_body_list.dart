import 'package:flutter/material.dart';

import 'table_list.dart';


class TableTabBodyList extends StatelessWidget {
  final String tabTitle;
  const TableTabBodyList({
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
          TableList(),
        ],
      ),
    );
  }
}
