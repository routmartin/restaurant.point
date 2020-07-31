
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void paymentMethod(context, size) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: size.height * 0.7,
            width: size.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: Colors.white),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xffFFFFE8)),
                      height: 70,
                      width: size.width * 0.8,
                      alignment: Alignment.center,
                      child: Text("Payment Methods",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Positioned(
                        top: -10,
                        right: -10,
                        child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.solidTimesCircle,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }))
                  ],
                ),

                Container()
              ],
            ),
          ),
        );
      },
    );
