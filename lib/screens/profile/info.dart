import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pointrestaurant/screens/login/login_screen.dart';
import 'package:pointrestaurant/utilities/path.dart';

import 'package:pointrestaurant/utilities/style.main.dart';
import 'package:pointrestaurant/widget/slash.screen.dart';
import 'package:splashscreen/splashscreen.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
              height: size.height * 0.6,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(red),
                      child: InkWell(
                        splashColor: Colors.black26,
                        onTap: () => Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SlashScreenShow(),
                          ),
                        ),
                        child: Container(
                          width: textfieldWidth,
                          height: 50.0,
                          child: Center(
                            child: Text(
                              "LOG OUT",
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
        ],
      ),
    );
  }
}
