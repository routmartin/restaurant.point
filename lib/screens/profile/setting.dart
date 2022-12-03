import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utilities/globals.dart' as globals;

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String txtPort = '';
  String txtIP = '';

  Future setSharePreferencNetworkConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('Port');
    prefs.remove('IP');
    prefs.setString('Port', txtPort);
    prefs.setString('IP', txtIP);
    return 'success';
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextStyle textStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: Colors.black87,
      fontFamily: 'San-francisco',
    );
    return Scaffold(
      backgroundColor: baseBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              height: size.height * .28,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/main.png',
                        width: 80,
                        height: 80,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'SOFTPOINT AUTU ID',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: Colors.black87,
                          fontFamily: 'San-francisco',
                        ),
                      ),
                    ],
                  )),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              height: size.height * .62,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'NETWORK configuration'.toUpperCase(),
                    style: textStyle,
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                      child: Column(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'IP Address',
                                textAlign: TextAlign.left,
                                style: textStyle,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                height: 50.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: TextFormField(
                                    onChanged: (txt) {
                                      txtIP = txt;
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: globals.ipAddress != null &&
                                              globals.ipAddress !=
                                                  '124.248.164.229'
                                          ? globals.ipAddress
                                          : 'No Configuration IP Address',
                                      contentPadding: EdgeInsets.all(15.0),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Port',
                                textAlign: TextAlign.left,
                                style: textStyle,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                height: 50.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: TextFormField(
                                    onChanged: (txt) {
                                      txtPort = txt;
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: globals.port != null &&
                                              globals.port != '5006'
                                          ? globals.port
                                          : 'No Configuration Port',
                                      contentPadding: EdgeInsets.all(15.0),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            height: 2,
                            color: Colors.black26,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              child: InkWell(
                            onTap: () {
                              if (txtPort != null &&
                                  txtIP != null &&
                                  txtIP.trim() != '' &&
                                  txtPort.trim() != '') {
                                setSharePreferencNetworkConfig().then((data) {
                                  if (data == 'success') {
                                    Navigator.pop(context, true);
                                  } else {
                                    validateTextfield();
                                  }
                                });
                              } else {
                                validateTextfield();
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: 'San-francisco',
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  validateTextfield() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text(
            "IP Address && Port can not empty !",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "San-francisco",
              fontSize: 16,
              color: Colors.black87,
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
                  color: Colors.black,
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
