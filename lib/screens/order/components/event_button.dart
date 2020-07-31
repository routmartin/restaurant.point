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
            ),
          ),
        ),
      ),
    );
  }
}
