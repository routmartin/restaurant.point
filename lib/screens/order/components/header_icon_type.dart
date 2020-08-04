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
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Material(
          color: isActive ? kPrimaryColor : Colors.grey[300],
          child: InkWell(
            splashColor: Colors.black12,
            onTap: () {},
            child: Container(
              height: 35,
              width: 100,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.white : Colors.black87,
                    fontSize: 15,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
