import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pointrestaurant/utilities/path.dart';
import 'package:pointrestaurant/utilities/style.main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../utilities/globals.dart' as globals;

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String _txtPort = '';
  String _txtIP = '';

  Future setSharePreferencNetworkConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('Port')) {
      prefs.remove('Port');
      prefs.remove('IP');
    }

    await prefs.setString('Port', _txtPort);
    await prefs.setString('IP', _txtIP);

    await prefs.setInt('bill', globals.bill);
    await prefs.setInt('pay', globals.pay);
    await prefs.setInt('reprint', globals.reprint);

    return true;
  }

  // Future setSharePreferencPrinterConfig() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('bill', globals.bill);
  //   prefs.setInt('pay', globals.pay);
  //   prefs.setInt('reprint', globals.reprint);

  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardWidth =
        size.width >= 1000 ? size.width * 0.35 : size.width * 0.9;
    return Scaffold(
      backgroundColor: baseBackgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context, true),
        backgroundColor: Colors.white,
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
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
                  height: size.width <= 400.0
                      ? size.height * 0.24
                      : size.width >= 1000.0
                          ? size.height * 0.2
                          : size.height * 0.2,
                  width: cardWidth,
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  decoration: cardDecoration,
                  child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            'SOFTPOINT AUTO ID',
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
                  height: size.width <= 360.0
                      ? size.height * 0.58
                      : size.width <= 400.0
                          ? size.height * 0.5
                          : size.width >= 1200.0
                              ? size.height * 0.38
                              : size.width >= 1000.0
                                  ? size.height * 0.4
                                  : size.height * 0.4,
                  width: cardWidth,
                  alignment: Alignment.center,
                  decoration: cardDecoration,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'printer configuration'.toUpperCase(),
                            style: textStyle,
                          ),
                          Icon(Icons.print)
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Bill Printing',
                                    style: textStyle,
                                  ),
                                  ToggleSwitch(
                                    minHeight: 35,
                                    minWidth: 90,
                                    activeBgColor: Colors.grey[800],
                                    activeFgColor: Colors.white,
                                    inactiveBgColor: Colors.grey[200],
                                    inactiveFgColor: Colors.black87,
                                    initialLabelIndex: globals.bill,
                                    icons: [
                                      Icons.phone_android,
                                      FontAwesomeIcons.print
                                    ],
                                    labels: [
                                      'M1',
                                      'Printer',
                                    ],
                                    onToggle: (index) {
                                      globals.bill = index;
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                height: 2,
                                color: Colors.black45,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Pay Printing',
                                    style: textStyle,
                                  ),
                                  ToggleSwitch(
                                    minHeight: 35,
                                    minWidth: 90,
                                    activeBgColor: Colors.grey[800],
                                    activeFgColor: Colors.white,
                                    inactiveBgColor: Colors.grey[200],
                                    inactiveFgColor: Colors.black87,
                                    initialLabelIndex: globals.pay,
                                    icons: [
                                      Icons.phone_android,
                                      FontAwesomeIcons.print
                                    ],
                                    labels: [
                                      'M1',
                                      'Printer',
                                    ],
                                    onToggle: (index) {
                                      globals.pay = index;
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                height: 2,
                                color: Colors.black45,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Reprinting',
                                    style: textStyle,
                                  ),
                                  ToggleSwitch(
                                    minHeight: 35,
                                    minWidth: 90,
                                    activeBgColor: Colors.grey[800],
                                    activeFgColor: Colors.white,
                                    inactiveBgColor: Colors.grey[200],
                                    inactiveFgColor: Colors.black87,
                                    initialLabelIndex: globals.reprint,
                                    icons: [
                                      Icons.phone_android,
                                      FontAwesomeIcons.print
                                    ],
                                    labels: [
                                      'M1',
                                      'Printer',
                                    ],
                                    onToggle: (index) {
                                      globals.reprint = index;
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  height: size.width <= 360.0
                      ? size.height * .65
                      : size.width <= 400.0
                          ? size.height * 0.5
                          : size.width >= 1200.0
                              ? size.height * 0.38
                              : size.width >= 1000.0
                                  ? size.height * 0.6
                                  : size.height * 0.4,
                  width: cardWidth,
                  alignment: Alignment.center,
                  decoration: cardDecoration,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'NETWORK configuration'.toUpperCase(),
                            style: textStyle,
                          ),
                          Icon(Icons.wifi_tethering)
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
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
                                          _txtIP = txt;
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
                                          _txtPort = txt;
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
                                height: 40,
                              ),
                              Container(
                                  child: InkWell(
                                onTap: () {
                                  if (_txtIP.trim().length > 0 &&
                                      _txtPort.trim().length > 0) {
                                    setSharePreferencNetworkConfig()
                                        .then((data) {
                                      if (data) {
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
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
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
