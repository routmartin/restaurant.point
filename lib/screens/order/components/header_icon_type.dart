import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/style.main.dart';

class IconbuttonType extends StatelessWidget {
  final String title;
  final bool isActive;
  const IconbuttonType({
    Key key,
    this.title,
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        color: isActive ? kPrimaryColor : Colors.transparent,
        child: InkWell(
          splashColor: Colors.black12,
          onTap: () {},
          child: Container(
            height: 35,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                width: 1.5,
                color: isActive ? kPrimaryColor : Colors.black54,
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.white : kPrimaryColor,
                  fontSize: 15,
                  fontFamily: "Roboto",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
