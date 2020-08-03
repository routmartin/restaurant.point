import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pointrestaurant/screens/order/components/event_button.dart';

void specialRequest(context, size) {
  var screeOrientation = MediaQuery.of(context).orientation;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                height: screeOrientation == Orientation.landscape
                    ? size.height * 0.8
                    : size.height * 0.58,
                width: screeOrientation == Orientation.landscape
                    ? size.width * 0.4
                    : double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      height: size.height * 0.1,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Spicy Fridge Egg",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text("\$0",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  right: 10,
                                  top: 0,
                                  child: Container(
                                    width: 100,
                                    child: Image.asset(
                                      "assets/images/food.jpg",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        color: Color(0xffF9F8F6),
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Special Request",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Spicy classic",
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    decoration: TextDecoration
                                                        .underline),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(flex: 2, child: Container()),
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color: Colors.grey[300],
                                                ),
                                                child: Text(
                                                  "choose 1 item",
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                            Expanded(
                              flex: 6,
                              child: Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: ListView.builder(
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.all(10.0),
                                          margin: EdgeInsets.only(
                                              top: 5.0, left: 5, right: 5.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 1),
                                                )
                                              ]),
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                FontAwesomeIcons.check,
                                                size: 15,
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text("$index Egg")
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.09),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Button(
                              buttonName: "Reset All",
                            ),
                            SizedBox(
                              width: screeOrientation == Orientation.landscape
                                  ? 100
<<<<<<< Updated upstream
                                  : size.width * 0.2,
=======
                                  : size.width * 0.25,
>>>>>>> Stashed changes
                            ),
                            Button(
                              buttonName: "Ok +9.99",
                            )
                          ],
                        ),
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
