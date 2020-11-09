import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pointrestaurant/screens/login/login_screen.dart';
import 'package:pointrestaurant/utilities/path.dart';
import 'package:pointrestaurant/utilities/style.main.dart';
import 'package:pointrestaurant/widget/slash.screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:pointrestaurant/services/closeshift/closeshift_services.dart';
import 'package:pointrestaurant/widget/action_button.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _cashKhmer;
  String _cashUsd;

  signIn() {
    SplashScreen(
      seconds: 3,
      navigateAfterSeconds: LoginScreen(),
      image: new Image.asset(
        appbarLogo,
        width: 120,
        height: 120,
      ),
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.white,
      imageBackground: AssetImage(
        backgroundImg,
      ),
    );
  }

  _checkCashInOperation() async {
    await cashRegistration().then((data) {
      _showCashInDialog(data: data);
    });
  }

  _cashIn({data}) {
    if (_cashUsd == null || _cashKhmer == null || int.parse(_cashKhmer) < 100) {
      validationDialog(message: 'Please fill valid data');
      return;
    }
    cashIn(cashInKHR: _cashKhmer, cashInUSD: _cashUsd).then((data) {
      if (data == 'success') {
        Navigator.pop(context);
      }
    });
  }

  removeLogInSharePreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('userLog');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: baseBackgroundColor,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  decoration: cardDecoration,
                  width: size.width >= 1200
                      ? size.width * 0.28
                      : size.width >= 1000
                          ? size.width * 0.35
                          : size.width * 0.9,
                  height: size.width >= 1200
                      ? size.width * 0.28
                      : size.width >= 1000
                          ? size.width * 0.35
                          : size.height * .3,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/main.png',
                          width: 120,
                          height: 120,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: Text(
                            'SOFTPOINT AUTO ID',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'San-francisco',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  decoration: cardDecoration,
                  width: size.width >= 1200
                      ? size.width * 0.28
                      : size.width >= 1000
                          ? size.width * 0.35
                          : size.width * 0.9,
                  height: size.width >= 1200
                      ? size.width * 0.28
                      : size.width >= 1000
                          ? size.width * 0.35
                          : size.height * .45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[800],
                          child: InkWell(
                              splashColor: Colors.black26,
                              onTap: () {
                                _checkCashInOperation();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.moneyBill,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  Container(
                                    height: 50.0,
                                    margin: EdgeInsets.only(left: 15),
                                    child: Center(
                                      child: Text(
                                        "Cash In",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[800],
                          child: InkWell(
                              splashColor: Colors.black26,
                              onTap: () {
                                _checkCashInOperation();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.money_off,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  Container(
                                    height: 50.0,
                                    margin: EdgeInsets.only(left: 15),
                                    child: Center(
                                      child: Text(
                                        "Cash Out",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: kPrimaryColor,
                          child: InkWell(
                              splashColor: Colors.black26,
                              onTap: () {
                                removeLogInSharePreference();
                                Navigator.of(context).pushReplacement(
                                  new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SlashScreenShow(),
                                  ),
                                );
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.signOutAlt,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  Container(
                                    height: 50.0,
                                    margin: EdgeInsets.only(left: 15),
                                    child: Center(
                                      child: Text(
                                        "Log Out",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validationDialog({String message}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "San-francisco",
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Cancel",
                style: TextStyle(
                  fontFamily: "San-francisco",
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _showCashInDialog({data}) async {
    await Future.delayed(Duration(milliseconds: 1000));
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          content: Container(
            padding: EdgeInsets.all(10),
            width: size.width >= 1200
                ? size.width * .2
                : size.width >= 1000 ? size.width * 0.3 : size.width * 0.9,
            height: size.width <= 360.0
                ? size.height * .52
                : size.width <= 400.0
                    ? size.height * .45
                    : size.width >= 1200.0
                        ? size.height * .38
                        : size.width >= 1000.0
                            ? size.height * .45
                            : size.height * .4,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: size.height * .06,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Cash In'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'San-francisco',
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(FontAwesomeIcons.moneyBill)
                    ],
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  Container(
                    width: size.width * .9,
                    height: 50.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: TextFormField(
                        onChanged: (kh) {
                          _cashKhmer = kh;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: data[0]['cash_in'],
                          labelText: 'KHR',
                          contentPadding: EdgeInsets.all(15.0),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .025,
                  ),
                  Container(
                    width: size.width * .8,
                    height: 50.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: TextFormField(
                        onChanged: (us) => _cashUsd = us,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: data[1]['cash_in'],
                          labelText: 'USD',
                          contentPadding: EdgeInsets.all(15.0),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            splashColor: Colors.black12,
                            child: ActionButton(
                              active: false,
                              btnLabel: 'cancel',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.black12,
                            onTap: () => _cashIn(data: data),
                            child: ActionButton(
                              active: true,
                              btnLabel: 'Cash In',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
