import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pointrestaurant/screens/profile/setting.dart';
import 'package:pointrestaurant/services/login.dart';

import 'package:pointrestaurant/utilities/style.main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utilities/globals.dart' as globals;
import '../main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = true;
  String checkUser = '';
  String checkPass = '';
  String checkCampany = '';

  Future getSharePreferencNetworkConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('Port') == false) {
      return 'noConfig';
    }
    globals.port = prefs.getString('Port');
    globals.ipAddress = prefs.getString('IP');
  }

  setSharePreferencLogIn(String userLog) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userLog', userLog);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textfieldWidth =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? size.width * 0.4
            : size.width * 0.8;
    var red = 0xffE50B2E;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/background.png',
                width: size.width,
                height: size.height,
                fit: BoxFit.cover,
              ),
            ],
          ),
          Positioned(
            top: size.height * 0.21,
            left: size.width * 0.05,
            child: Container(
              height: size.height * 0.72,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 40.0),
                      child: Text(
                        'SOFTPOINT AUTO ID',
                        style: TextStyle(
                          fontSize: 25,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'San-francisco',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30.0),
                      width: textfieldWidth,
                      height: 50.0,
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          onChanged: (val) {
                            setState(
                              () {
                                checkCampany = val;
                              },
                            );
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 15),
                            hintText: 'Enter Company Profile',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.business,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: textfieldWidth,
                      height: 50.0,
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          onChanged: (val) {
                            setState(
                              () {
                                checkUser = val;
                              },
                            );
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 10),
                            hintText: 'Enter Username',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: textfieldWidth,
                      height: 50.0,
                      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey[200],
                      ),
                      child: Center(
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          onChanged: (val) {
                            setState(() {
                              checkPass = val;
                            });
                          },
                          obscureText: showPassword,
                          decoration: InputDecoration(
                            hintText: "Enter Password",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                            border: InputBorder.none,
                            fillColor: Colors.black,
                            prefixIcon: Icon(Icons.lock, color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: showPassword
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: Colors.grey,
                                    ),
                              onPressed: () {
                                setState(
                                  () {
                                    showPassword = !showPassword;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color(red),
                        child: InkWell(
                          splashColor: Colors.black26,
                          onTap: () {
                            getSharePreferencNetworkConfig().then((data) {
                              if (data == 'noConfig') {
                                validationDialog('No Network Configuration');
                              } else {
                                if (checkPass != null &&
                                    checkUser != null &&
                                    checkCampany != null &&
                                    checkUser.trim() != '' &&
                                    checkCampany.trim() != '' &&
                                    checkPass.trim() != '') {
                                  logInSubmit(
                                          checkCampany, checkUser, checkPass)
                                      .then(
                                    (value) {
                                      if (value == 'Username' ||
                                          value == 'Password' ||
                                          value == 'Company') {
                                        validationDialog(value);
                                      } else {
                                        setSharePreferencLogIn(value);
                                        globals.userToken = value;
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => MainScreenPage(),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                } else if (checkUser.trim() == '' ||
                                    checkPass.trim() == '') {
                                  validateTextfield();
                                }
                              }
                            });
                          },
                          child: Container(
                            width: textfieldWidth,
                            height: 50.0,
                            child: Center(
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
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
          ),
          Positioned(
            top: size.height * .1,
            right: 30,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingScreen(),
                  ),
                ).then(
                    (data) => data ? getSharePreferencNetworkConfig() : null);
              },
              child: Container(
                child: SvgPicture.asset(
                  'assets/icons/settings.svg',
                  width: 30.0,
                  height: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void validationDialog(String message) {
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

  void validateTextfield() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text(
            "Company && Username && Password can't empty!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "San-francisco",
              fontWeight: FontWeight.bold,
              color: Colors.black87,
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
}
