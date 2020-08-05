import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/style.main.dart';

class Button extends StatelessWidget {
  final String buttonName;
  final Function press;

  Button({this.buttonName, this.press});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screeOrientation = MediaQuery.of(context).orientation;
    var lanscape = Orientation.landscape;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        color: kPrimaryColor,
        child: InkWell(
          splashColor: Colors.white24,
          onTap: press,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 14,
            ),
            width: screeOrientation == lanscape ? 120 : size.width * 0.3,
            height: screeOrientation == Orientation.landscape
                ? size.height * 0.06
                : size.height * 0.05,
            child: Center(
              child: Text(
                buttonName,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: 'San-francisco',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
