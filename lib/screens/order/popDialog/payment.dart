import 'package:flutter/material.dart';
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
          width: size.width * 0.8,
          height: size.height * 0.6,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
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
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
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
                                            style: TextStyle(fontSize: 10.0),
                                          ),
                                          // SizedBox(height: 5),
                                          Text('Total',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: kPrimaryColor)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      margin: EdgeInsets.only(right: 15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text('20',
                                              style: TextStyle(fontSize: 10.0)),
                                          // SizedBox(height: 5),
                                          Text(
                                            '\$538.4',
                                            style:
                                                TextStyle(color: kPrimaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
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
                ),
              ),
              _buildCancelButton(context)
            ],
          ),
        ),
      );
    },
  );
}

_buildCancelButton(BuildContext context) {
  return Positioned(
    top: 0,
    right: 0,
    child: Material(
      color: Color(0xffcc2d2d),
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        splashColor: Colors.white38,
        child: Container(
          width: 25,
          height: 25,
          child: Center(
            child: Text(
              'x',
              style: TextStyle(
                color: Colors.white,
                fontFamily: "San-francisco",
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
