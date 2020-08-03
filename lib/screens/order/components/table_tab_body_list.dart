import 'package:flutter/material.dart';

import 'table_card.dart';

class TableTabBodyList extends StatelessWidget {
  final String tabTitle;
  const TableTabBodyList({
    Key key,
    this.tabTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var orientation =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Column(
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
        GridView.count(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          childAspectRatio:
              orientation ? size.height / 800 : size.height / 1100,
          crossAxisCount:
              size.width <= 800.0 ? 3 : size.width >= 1000.0 ? 5 : 4,
          children: new List<Widget>.generate(
            10,
            (index) {
              return TableCard();
            },
          ),
        ),
      ],
    );
  }
}
