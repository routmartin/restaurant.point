
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pointrestaurant/screens/order/components/event_button.dart';
import 'package:pointrestaurant/screens/order/components/order_list.dart';
import 'package:pointrestaurant/utilities/style.main.dart';

void payDialog(context, size) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Stack(
                children: <Widget>[
                  Container(
                      height: size.height * 0.7,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          Container(
                              height: size.height * 0.07,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.blueGrey[50]),
                                alignment: Alignment.center,
                                child: Text(
                                  "Your Order Summary(Dine In)",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                          OrderList(size: size),
                          Container(
                            height: size.height * 0.08,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 100.0,
                                  height: 30.0,
                                  margin: EdgeInsets.only(left: 10.0),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.black),
                                  child: Text(
                                    "Use Cupon",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Quantity',
                                                  style:
                                                      TextStyle(fontSize: 10.0),
                                                ),
                                                // SizedBox(height: 5),
                                                Text('Total',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            kPrimaryColor)),
                                              ],
                                            )),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Container(
                                            alignment: Alignment.centerRight,
                                            margin:
                                                EdgeInsets.only(right: 15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text('20',
                                                    style: TextStyle(
                                                        fontSize: 10.0)),
                                                // SizedBox(height: 5),
                                                Text(
                                                  '\$538.4',
                                                  style: TextStyle(
                                                      color: kPrimaryColor),
                                                ),
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            height: size.height * 0.08,
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Button(
                                      buttonName: "Continue",
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Button(
                                      buttonName: "Pay",
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                  Positioned(
                    child: Icon(
                      FontAwesomeIcons.solidTimesCircle,
                      color: Colors.red,
                    ),
                    top: 0,
                    right: 0,
                  )
                ],
              ),
            ));
      });
}
