import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/style.main.dart';


import 'restaurent_card.dart';

class ListScrollHome extends StatelessWidget {
  const ListScrollHome({
    Key key,
    @required this.size,
    this.title,
    this.imgPath,
  }) : super(key: key);

  final Size size;
  final String title;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            title,
            style: homeTitle,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: size.height * .28,
          width: double.infinity,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (BuildContext ctx, int index) {
                return RestaurantCard(
                  title: 'Point Restaurant',
                  imgPath: imgPath,
                  press: () {},
                );
              }),
        )
      ],
    );
  }
}
