import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/style.main.dart';

class BorderButton extends StatelessWidget {
  final String title;

  const BorderButton({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 120,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 1.5, color: kPrimaryColor),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
            fontSize: 15,
            fontFamily: "Roboto",
          ),
        ),
      ),
    );
  }
}
