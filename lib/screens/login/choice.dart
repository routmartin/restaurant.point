import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utilities/path.dart';
import 'components/button.dart';
import 'components/chooseLanguage.dart';

class ChoiceScreen extends StatelessWidget {
  // bool lang = true;
  // _language(language) async {
  //   SharedPreferences lang = await SharedPreferences.getInstance();
  //   lang.setBool('lang', language);
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screeOrientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/background.png',
              width: size.width,
              height: size.height,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: size.height * 0.2,
              child: Container(
                width: size.width,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        appbarLogo,
                        width: screeOrientation == Orientation.landscape
                            ? size.width * 0.15
                            : size.width * 0.3,
                        height: screeOrientation == Orientation.landscape
                            ? size.width * 0.15
                            : size.width * 0.4,
                      ),
                      Text(
                        "Point Restaurant",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: screeOrientation == Orientation.landscape
                  ? size.width * 0.35
                  : size.width * 0.98,
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Button(
                      name: "REGISTER",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Button(
                      name: "LOGIN",
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: size.height * 0.1,
              child: ChooseLanguage(),
            )
          ],
        ),
      ),
    );
  }
}
