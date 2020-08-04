import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/style.main.dart';

class HeaderStack extends StatelessWidget {
  final double height;
  const HeaderStack({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kPrimaryColor,
                Color(0xFFeb4438),
              ],
            ),
          ),
          height: height,
        ),
        new AppBar(
          leading: null,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: new Text(
            "Payment",
            style: TextStyle(
              fontFamily: 'NothingYouCouldDo',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
