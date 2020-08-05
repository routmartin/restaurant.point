import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pointrestaurant/utilities/style.main.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

import 'components/event_button.dart';
import 'components/header_icon_type.dart';
import 'components/bottom_label_checkout.dart';
import 'components/floor_container.dart';
import 'components/order_cal_icon.dart';

import 'components/table_card.dart';

class TableScreen extends StatefulWidget {
  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  int _pageState = 0;

  var _backgroundColor = Colors.white;
  var _headingColor = Color(0xFFB40284A);

  double _headingTop = 100;

  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _registerYOffset = 0;
  double _registerHeight = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  bool _keyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    _loginHeight = windowHeight - 200;
    _registerHeight = windowHeight - 200;

    switch (_pageState) {
      case 0:
        _backgroundColor = Colors.white;
        _headingColor = Color(0xFFB40284A);

        _headingTop = 100;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = windowHeight;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 270;
        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 1:
        _backgroundColor = Colors.white;
        _headingColor = Colors.white;

        _headingTop = 10;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = _keyboardVisible ? 40 : 200;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 180;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 2:
        _backgroundColor = Colors.white;
        _headingColor = Colors.white;

        _headingTop = 80;

        _loginWidth = windowWidth - 40;
        _loginOpacity = 0.7;

        _loginYOffset = _keyboardVisible ? 30 : 180;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 180;

        _loginXOffset = 20;
        _registerYOffset = _keyboardVisible ? 55 : 270;
        _registerHeight = _keyboardVisible ? windowHeight : windowHeight - 100;
        break;
    }

    var size = MediaQuery.of(context).size;
    var orientation =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            color: _backgroundColor,
            child: Container(
              child: Stack(
                children: <Widget>[
                  _buildTableContainer(size, orientation),
                  BottomLabelCheckOut(),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                      width: size.width * .28,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Material(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(4),
                        child: InkWell(
                          onTap: () {
                            // orderSummary(context: context, size: size);
                            setState(() {
                              if (_pageState != 0) {
                                _pageState = 0;
                              } else {
                                _pageState = 1;
                              }
                            });
                          },
                          splashColor: Colors.white24,
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '\$ 00.00',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 40,
                                      height: 22,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        'USA',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      'Order',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          AnimatedContainer(
            width: _loginWidth,
            height: _loginHeight,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            transform:
                Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
            decoration: BoxDecoration(
              color: Color(0xfffcfcfc),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: Offset(1, 5),
                  color: Colors.black38.withOpacity(.2),
                  blurRadius: 20,
                  spreadRadius: 10,
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  height: orientation ? size.height * 0.8 : double.infinity,
                  width: orientation ? size.width * 0.4 : double.infinity,
                  child: Column(
                    children: <Widget>[
                      _buildHeaderTitle(size),
                      Container(
                        height: orientation
                            ? size.height * 0.52
                            : size.height * 0.35,
                        color: Color(0xfff0f0f0),
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Container(
                              alignment: Alignment.centerLeft,
                              height: 70,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 0.2, color: Colors.grey),
                                ),
                              ),
                              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: _buildRowTitleItem(),
                                        ),
                                        _buildTotalPrice(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      CaculateIcon(),
                                      SizedBox(width: 10),
                                      _buildSpecilRequest(context)
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      _buildTotalAmountContainer(size, context),
                      _buildButtonContainer(size, context)
                    ],
                  ),
                ),
                _buildCancelButton(context)
              ],
            ),
          ),
          AnimatedContainer(
            height: _registerHeight,
            padding: EdgeInsets.all(32),
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            transform: Matrix4.translationValues(0, _registerYOffset, 1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: size.height * 0.1,
                          color: Colors.red,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Spicy Fridge Egg",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text("\$0",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
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
                        Container(
                          height: size.height * .3,
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
                                                    fontWeight: FontWeight.bold,
                                                  ),
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
                                            Expanded(
                                                flex: 2, child: Container()),
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
                        Container(
                          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.09),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Button(
                                buttonName: "Reset All",
                              ),
                              SizedBox(
                                width: orientation ? 100 : 20,
                              ),
                              Button(
                                buttonName: "Ok +9.99",
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

// special Request___________________________________

  _buildSpecilRequest(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black54,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _pageState = 2;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              "SPECIAL REQUEST",
              style: TextStyle(
                fontSize: 7,
                fontFamily: 'San-francisco',
                fontWeight: FontWeight.w800,
                letterSpacing: 1.02,
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildTotalPrice() {
    return Expanded(
      flex: 1,
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          "\$12.50",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  _buildRowTitleItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "Brown Suger Jelly",
          style: TextStyle(
            letterSpacing: 1.1,
            fontFamily: 'San-francisco',
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "\$ 12.50",
          style: TextStyle(
            fontFamily: 'San-francisco',
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

// special Request___________________________________

  // orderSummery inner_width________________________

  _buildCancelButton(BuildContext context) {
    return Positioned(
      top: 7,
      right: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          color: Color(0xffcc2d2d),
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: () {
              setState(() {
                if (_pageState != 0) {
                  _pageState = 0;
                } else {
                  _pageState = 1;
                }
              });
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
      ),
    );
  }

  _buildHeaderTitle(size) {
    return Container(
      height: size.height * 0.08,
      decoration: BoxDecoration(
        color: bkColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        "Your Order Summary(Dine In)",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _buildButtonContainer(size, BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Container(
      height: orientation == Orientation.landscape
          ? size.height * 0.1
          : size.height * 0.08,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        // color: bkColor,
        color: bkColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: FittedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Button(
              buttonName: "Continue",
            ),
            SizedBox(
              width: 10,
            ),
            Button(
              buttonName: "Option",
            ),
            SizedBox(
              width: 10,
            ),
            Button(
              buttonName: "Confirm",
              press: () {
                // payDialog(context, size);
                // show(context);
              },
            )
          ],
        ),
      ),
    );
  }

  _buildTotalAmountContainer(size, BuildContext context) {
    return Container(
      height: size.height * 0.08,
      color: Color(0xfff0f0f0),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              // paymentMethod(context, size);
            },
            child: _buildCupon(),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Quantity',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '20',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '\$538.4',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildCupon() {
    return Container(
      width: 100.0,
      height: 25.0,
      margin: EdgeInsets.only(left: 10.0),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black87,
      ),
      child: Text(
        "Use Cupon",
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }

  // orderSummery inner_width________________________

  _buildTableContainer(Size size, bool orientation) {
    return Container(
      height: size.height,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 10,
                color: Colors.black12,
              )
            ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildHeaderChoice(),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: size.height,
              child: VerticalTabs(
                indicatorColor: Color(0xffb01105),
                tabsWidth: orientation ? size.width * .09 : size.width * .23,
                selectedTabBackgroundColor: null,
                contentScrollAxis: Axis.vertical,
                tabs: List.generate(
                  5,
                  (index) {
                    return Tab(
                      child: FloorContainer(
                        index: index + 1,
                      ),
                    );
                  },
                ),
                contents: List.generate(
                  5,
                  (index) {
                    return Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Text(
                            'Floor ' + index.toString(),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'San-francisco',
                            ),
                          ),
                        ),
                        Expanded(
                          child: _buildGridViewTable(orientation, size),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildGridViewTable(bool orientation, Size size) {
    return GridView.count(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      childAspectRatio: orientation ? size.height / 800 : size.height / 1100,
      crossAxisCount: size.width <= 800.0 ? 3 : size.width >= 1000.0 ? 5 : 4,
      children: List<Widget>.generate(
        40,
        (index) {
          return TableCard(
            index: index,
          );
        },
      ),
    );
  }

  _buildHeaderChoice() {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconbuttonType(
            title: 'Dine In',
            isActive: false,
          ),
          IconbuttonType(
            title: 'Table',
            isActive: true,
          ),
          IconbuttonType(
            title: 'Take Out',
            isActive: false,
          ),
        ],
      ),
    );
  }
}
