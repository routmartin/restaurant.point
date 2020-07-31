import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utilities/path.dart';
import 'components/button.dart';
import 'components/chooseLanguage.dart';


class ChoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/background.png',
                width: size.width,
                height: size.height,
                fit: BoxFit.fill,
              ),
              Positioned(
                  top: size.height * 0.1,
                  child: Container(
                    width: size.width,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            appbarLogo,
                            width: size.width * 0.3,
                            height: size.width * 0.3,
                          ),
                          Text(
                            "Point Restaurant",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )),
              Positioned(
                top: size.height * 0.4,
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
                    )),
              ),
              Positioned(
                bottom: size.height * 0.1,
                child: ChooseLanguage(),
              )
            ],
          )),
    ));
  }
}
