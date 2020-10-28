import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pointrestaurant/screens/login/login_screen.dart';
import 'package:pointrestaurant/utilities/path.dart';
import 'package:pointrestaurant/utilities/style.main.dart';
import 'package:pointrestaurant/widget/slash.screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  removeLogInSharePreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('userLog');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textfieldWidth =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? size.width * 0.4
            : size.width * 0.8;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
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
            SizedBox(
              height: 40,
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
                        builder: (BuildContext context) => SlashScreenShow(),
                      ),
                    );
                  },
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
    );
  }
}
