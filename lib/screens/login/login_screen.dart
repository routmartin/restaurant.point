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
  String authUser;
  String authPass;

  void getSharePreferencNetworkConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userLog')) {
      prefs.remove('userLog');
    }
    if (prefs.containsKey('Port')) {
      globals.port = prefs.getString('Port');
      globals.ipAddress = prefs.getString('IP');
    } else {
      globals.ipAddress = '124.248.164.229';
      globals.port = '5006';
    }
  }

  Future setSharePreferencLogIn(String userLog) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userLog', userLog);
  }

  @override
  Widget build(BuildContext context) {
    bool orientation =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var size = MediaQuery.of(context).size;
    var textfieldWidth =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? size.width * 0.4
            : size.width * 0.8;
    var red = 0xffE50B2E;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/images/background.png',
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(
                  top: size.height * 0.05,
                ),
                child: InkWell(
                  onTap: () {
                    _showAuthenticator();
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
              ),
              SizedBox(
                height: size.height * .05,
              ),
              Container(
                height: size.height * 0.72,
                width: orientation ? size.width * 0.45 : size.height * 0.9,
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
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
                            contentPadding: EdgeInsets.only(top: 16),
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
                            if (checkPass != null &&
                                checkUser != null &&
                                checkUser.trim() != '' &&
                                checkPass.trim() != '') {
                              getSharePreferencNetworkConfig();
                              logInSubmit(checkCampany, checkUser, checkPass)
                                  .then(
                                (token) {
                                  if (token == 'Username' ||
                                      token == 'Password' ||
                                      token == 'Company') {
                                    validationDialog(token);
                                  } else {
                                    setSharePreferencLogIn(token).then((_) {
                                      globals.userToken = token;
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => MainScreenPage(),
                                        ),
                                      );
                                    });
                                  }
                                },
                              );
                            } else if (checkUser.trim() == '' ||
                                checkPass.trim() == '') {
                              validateTextfield();
                            }
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
            ],
          ),
        ),
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

  _showAuthenticator() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        var size = MediaQuery.of(context).size;
        bool orientation =
            MediaQuery.of(context).orientation == Orientation.landscape;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          content: Container(
            padding: EdgeInsets.all(10),
            width: orientation ? size.width * .4 : size.width * .95,
            height: orientation ? size.height * .38 : size.height * .52,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: size.height * .06,
                  ),
                  Text(
                    'Authenticator'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'San-francisco',
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none,
                    ),
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
                        onChanged: (txtUser) => authUser = txtUser,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          contentPadding: EdgeInsets.all(15.0),
                          border: InputBorder.none,
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
                        onChanged: (txtPass) => authPass = txtPass,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding: EdgeInsets.all(15.0),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  FittedBox(
                    alignment: Alignment.center,
                    child: Row(
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
                              child: Container(
                                width: orientation
                                    ? size.width * .14
                                    : size.width * .27,
                                height: 45.0,
                                alignment: Alignment.center,
                                decoration:
                                    BoxDecoration(color: Colors.black12),
                                padding: EdgeInsets.symmetric(
                                  vertical: 9,
                                  horizontal: 20,
                                ),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 13,
                                    decoration: TextDecoration.none,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
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
                              onTap: () {
                                if (authUser == 'martin' && authPass == '123') {
                                  Navigator.pop(context);
                                  authPass = '';
                                  authUser = '';
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SettingScreen(),
                                    ),
                                  ).then(
                                    (data) => data != null
                                        ? data
                                            ? getSharePreferencNetworkConfig()
                                            : null
                                        : null,
                                  );
                                } else {
                                  validationDialog(
                                      'Invalid Username or Password');
                                }
                              },
                              splashColor: Colors.black12,
                              child: Container(
                                height: 45.0,
                                width: orientation
                                    ? size.width * .14
                                    : size.width * .27,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 9,
                                  horizontal: 20,
                                ),
                                child: Text(
                                  'Confirm',
                                  style: TextStyle(
                                    fontSize: 13,
                                    decoration: TextDecoration.none,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
