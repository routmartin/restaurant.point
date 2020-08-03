// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/style.main.dart';

class Button extends StatelessWidget {
  final String buttonName;
  final Function press;

  Button({this.buttonName, this.press});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      borderRadius: BorderRadius.circular(20.0),
<<<<<<< Updated upstream
      color: kPrimaryColor,
      child: InkWell(
        onTap: press,
        child: Container(
          width: size.width * 0.25,
          height: size.height * 0.045,
          alignment: Alignment.center,
          child: Text(
            buttonName,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
=======
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
            width: screeOrientation == Orientation.landscape ? 120 : 90,
            height: screeOrientation == Orientation.landscape
                ? size.height * 0.06
                : size.height * 0.045,
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
>>>>>>> Stashed changes
            ),
          ),
        ),
      ),
    );
  }
}
