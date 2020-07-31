import 'package:flutter/material.dart';

import 'card_food.dart';

class SubCategoryList extends StatelessWidget {
  const SubCategoryList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .64,
      child: SingleChildScrollView(
        child: GridView.count(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          childAspectRatio: MediaQuery.of(context).size.height / 1000,
          crossAxisCount: MediaQuery.of(context).size.width <= 800.0
              ? 3
              : MediaQuery.of(context).size.width >= 1000.0 ? 2 : 3,
          children: new List<Widget>.generate(
            9,
            (index) {
              return CardFood();
            },
          ),
        ),
      ),
    );
  }
}
