import 'package:flutter/material.dart';

import 'table_card.dart';

class TableList extends StatelessWidget {
  const TableList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var orientation =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Container(
      child: SingleChildScrollView(
        child: GridView.count(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          childAspectRatio:
              orientation ? size.height / 800 : size.height / 1000,
          crossAxisCount:
              size.width <= 800.0 ? 3 : size.width >= 1000.0 ? 5 : 4,
          children: new List<Widget>.generate(
            10,
            (index) {
              return TableCard();
            },
          ),
        ),
      ),
    );
  }
}
