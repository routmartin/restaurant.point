import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChooseLanguage extends StatefulWidget {
  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  var path = "assets/images/";
  var flage = "english.png";
  var language = "English";
  var enCheck = Color(0xffE50B2E);
  var khCheck = Colors.white;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var buttonWidth = size.width * 0.8;

    void _showModalSheet() {
      showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (builder) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0))),
              height: size.height * 0.3,
              width: size.width,
              child: Column(
                children: <Widget>[
                  Container(
                    width: size.width,
                    height: 50,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          flage = "khmer.png";
                          language = "ភាសាខ្មែរ";
                          khCheck = Color(0xffE50B2E);
                          enCheck = Colors.white;
                        });
                        Navigator.pop(context);
                      },
                      child: Align(
                          // alignment: Alignment.centerLeft,
                          child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/khmer.png",
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "ភាសាខ្មែរ",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )
                            ],
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              FontAwesomeIcons.solidCheckCircle,
                              color: khCheck,
                            ),
                          ))
                        ],
                      )),
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 50,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            flage = "english.png";
                            language = "English";
                            enCheck = Color(0xffE50B2E);
                            khCheck = Colors.white;
                          });
                          Navigator.pop(context);
                        },
                        child: Align(
                            // alignment: Alignment.centerLeft,
                            child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Row(
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/english.png",
                                  width: 40,
                                  height: 40,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "English",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            )),
                            Expanded(
                                child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                FontAwesomeIcons.solidCheckCircle,
                                color: enCheck,
                              ),
                            ))
                          ],
                        )),
                      ),
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.all(20.0),
            );
          });
    }

    return Container(
      width: size.width,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text(
              "Please Choose Your Preferred Language",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              width: buttonWidth,
              height: 50.0,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.white),
                  borderRadius: BorderRadius.circular(40.0),
                  color: Colors.white),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    _showModalSheet();
                  },
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              path + flage,
                              width: 40,
                              height: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              language,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          FontAwesomeIcons.angleDown,
                          color: Colors.red,
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
