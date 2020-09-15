import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/style.main.dart';

class Button extends StatelessWidget {
  final String buttonName;
  final Function press;
  final bool border;

  Button({
    this.buttonName,
    this.press,
    this.border = false,
  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screeOrientation = MediaQuery.of(context).orientation;
    var lanscape = Orientation.landscape;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: border ? Colors.grey[200] : kPrimaryColor,
        child: InkWell(
          splashColor: Colors.black54,
          onTap: press,
          child: Container(
            alignment: Alignment.center,
            width: screeOrientation == lanscape ? 120 : size.width * 0.28,
            height: screeOrientation == Orientation.landscape
                ? size.height * 0.054
                : 35,
            child: Text(
              buttonName,
              style: TextStyle(
                fontSize: 14,
                color: border ? kPrimaryColor : Colors.white,
                fontFamily: 'San-francisco',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
