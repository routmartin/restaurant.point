import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login_screen.dart';

class Button extends StatelessWidget {
  final name;
  Button({this.name});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screeOrientation = MediaQuery.of(context).orientation;
    var buttonWidth = screeOrientation == Orientation.landscape
        ? size.width * 0.4
        : size.width * 0.8;
    return ClipRRect(
      borderRadius: BorderRadius.circular(40.0),
      child: Container(
        width: buttonWidth,
        height: 50.0,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(40.0),
          color: Colors.transparent,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (name == "LOGIN") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LoginScreen(),
                  ),
                );
              }
            },
            child: Center(
              child: Text(
                "$name",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
