import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentList extends StatelessWidget {
  final Size size;
  final String name;
  final String image;
  final bool isCheck;
  PaymentList({
    this.size,
    this.name,
    this.image,
    this.isCheck: false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: 50,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Align(
              // alignment: Alignment.centerLeft,
              child: Row(
            children: <Widget>[
              Expanded(
                  child: Row(
                children: <Widget>[
                  Image.asset(
                    "assets/images/" + image,
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              )),
              Container(
                width: 20,
                child: Icon(
                  FontAwesomeIcons.checkCircle,
                  color: (isCheck) ? Colors.red : Colors.transparent,
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
