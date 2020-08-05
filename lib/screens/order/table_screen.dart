import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/style.main.dart';
import 'package:vertical_tabs/vertical_tabs.dart';
import 'components/event_button.dart';
import 'components/header_icon_type.dart';
import 'components/bottom_label_checkout.dart';
import 'components/floor_container.dart';
import 'components/order_list.dart';
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

        _loginYOffset = _keyboardVisible ? 40 : 160;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 190;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 2:
        _backgroundColor = Color(0xFFBD34C59);
        _headingColor = Colors.white;

        _headingTop = 80;

        _loginWidth = windowWidth - 40;
        _loginOpacity = 0.7;

        _loginYOffset = _keyboardVisible ? 30 : 240;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 240;

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
          buildAnimatedContainerSecond(size, orientation),
          buildAnimatedContainerThird()
        ],
      )),
    );
  }

  buildAnimatedContainerThird() {
    return AnimatedContainer(
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Create a New Account",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              InputWithIcon(
                icon: Icons.email,
                hint: "Enter Email...",
              ),
              SizedBox(
                height: 20,
              ),
              InputWithIcon(
                icon: Icons.vpn_key,
                hint: "Enter Password...",
              )
            ],
          ),
          Column(
            children: <Widget>[
              PrimaryButton(
                btnText: "Create Account",
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _pageState = 1;
                  });
                },
                child: OutlineBtn(
                  btnText: "Back To Login",
                ),
              ),
              SizedBox(
                height: 200,
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildAnimatedContainerSecond(Size size, orientation) {
    return AnimatedContainer(
      width: _loginWidth,
      height: _loginHeight,
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 1000),
      transform: Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
      decoration: BoxDecoration(
        // color: Colors.white.withOpacity(_loginOpacity),
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
            height: orientation == Orientation.landscape
                ? size.height * 0.8
                : double.infinity,
            width: orientation == Orientation.landscape
                ? size.width * 0.4
                : double.infinity,
            child: Column(
              children: <Widget>[
                _buildHeaderTitle(size),
                OrderList(size: size),
                _buildTotalAmountContainer(size, context),
                _buildButtonContainer(size, context)
              ],
            ),
          ),
          _buildCancelButton(context)
        ],
      ),
    );
  }

  // orderSummery inner_width________________________

  _buildCancelButton(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
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
    var ori = MediaQuery.of(context).orientation;
    return Container(
      height:
          ori == Orientation.landscape ? size.height * 0.1 : size.height * 0.08,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
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
            // Material(
            //   color: Colors.transparent,
            //   child: InkWell(
            //     onTap: () {},
            //     child: Container(
            //       width: size.width * 0.25,
            //       height: size.height * 0.045,
            //       alignment: Alignment.center,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20.0),
            //         color: kPrimaryColor,
            //       ),
            //       child: DropdownButton<String>(
            //         value: _chosenValue,
            //         underline: Container(), // this is the magic
            //         items: <String>['Google', 'Apple', 'Amazon', 'Tesla']
            //             .map<DropdownMenuItem<String>>(
            //           (String value) {
            //             return DropdownMenuItem<String>(
            //               value: value,
            //               child: Text(
            //                 value,
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                   fontSize: 13,
            //                   color: Colors.black,
            //                 ),
            //               ),
            //             );
            //           },
            //         ).toList(),
            //         onChanged: (String value) {
            //           // setState(
            //           //   () {
            //           //     _chosenValue = value;
            //           //   },
            //           // );
            //         },
            //       ),
            //     ),
            //   ),
            // ),
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

class InputWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  InputWithIcon({this.icon, this.hint});

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFBC7C7C7), width: 2),
          borderRadius: BorderRadius.circular(50)),
      child: Row(
        children: <Widget>[
          Container(
              width: 60,
              child: Icon(
                widget.icon,
                size: 20,
                color: Color(0xFFBB9B9B9),
              )),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  border: InputBorder.none,
                  hintText: widget.hint),
            ),
          )
        ],
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final String btnText;
  PrimaryButton({this.btnText});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFB40284A), borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class OutlineBtn extends StatefulWidget {
  final String btnText;
  OutlineBtn({this.btnText});

  @override
  _OutlineBtnState createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFB40284A), width: 2),
          borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Color(0xFFB40284A), fontSize: 16),
        ),
      ),
    );
  }
}
