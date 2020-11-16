import 'dart:typed_data';

import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';
import 'package:pointrestaurant/screens/login/login_screen.dart';
import 'package:pointrestaurant/utilities/path.dart';
import 'package:pointrestaurant/utilities/style.main.dart';
import 'package:pointrestaurant/widget/slash.screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:pointrestaurant/services/closeshift/closeshift_services.dart';
import 'package:pointrestaurant/widget/action_button.dart';
import 'package:image/image.dart' as Martin;
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
// ++++++++++++++++++++++++++++++++++ Section Working with Network Printer ++++++++++++++++++++++++++++++++

  PrinterNetworkManager printerManager = PrinterNetworkManager();
  Map<int, Uint8List> imgListBytes = Map();

  _printWithNetwork({ip}) async {
    String path = '$serverIP/temp/cashout.png';
    await networkImageToByte(path).then((bytes) {
      imgListBytes[1] = bytes;
      _connectPrinter(ip, 1);
    });
  }

  _connectPrinter(host, int index) async {
    printerManager.selectPrinter(host,
        port: 9100, timeout: Duration(milliseconds: 500));
    await printerManager.printTicket(await testTicket(index));
  }

  Future<Ticket> testTicket(index) async {
    final profile = await CapabilityProfile.load();
    final Ticket ticket = Ticket(PaperSize.mm80, profile);
    var image = Martin.decodeImage(imgListBytes[index]);
    ticket.image(image);
    ticket.feed(2);
    ticket.cut();
    return ticket;
  }

// ++++++++++++++++++++++++++++++++++ Section Working with Network Printer ++++++++++++++++++++++++++++++++

  @override
  void initState() {
    super.initState();
    cashRegistration().then((data) {
      if (data[0]['cash_id'].toString().isEmpty) {
        _showCashInDialog(data: data);
      }
    });
  }

  String _cashKhmer;
  String _cashUsd;
  String _phone = '095659666';

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
        enableJavaScript: true,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

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

  _checkCashInOperation({bool check}) async {
    await cashRegistration().then((data) {
      check ? _showCashInDialog(data: data) : _showCashOutDialog(data: data);
    });
  }

  _cashIn({data}) {
    if (_cashUsd == null || _cashKhmer == null || int.parse(_cashKhmer) < 100) {
      validationDialog(message: 'Please fill valid data');
      return;
    }
    cashIn(
      cashInKHR: _cashKhmer,
      cashInUSD: _cashUsd,
      cashRegisterId: data[0]['cash_id'],
      cashOne: data[0]['cash_detail_id'],
      cashTwo: data[1]['cash_detail_id'],
    ).then((data) {
      if (data == 'success') {
        Navigator.pop(context);
      }
    });
  }

  _cashOut({data}) {
    if (_cashUsd == null ||
        _cashKhmer == null ||
        int.parse(_cashKhmer) < 100 ||
        int.parse(_cashUsd) < 0) {
      validationDialog(message: 'Please fill valid data');
      return;
    }
    cashOut(
      cashInKHR: _cashKhmer,
      cashInUSD: _cashUsd,
      cashRegisterId: data[0]['cash_id'],
    ).then((data) {
      if (data == 'no_item') {
        validationDialog(message: 'No item sold yet');
        return;
      }
      _printWithNetwork(ip: data[0]['host']);
      _logOut();
    });
  }

  _logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('userLog')) {
      pref.remove('userLog');
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute(
          builder: (BuildContext context) => SlashScreenShow(),
        ),
      );
    }
  }

  TextStyle headerTxtStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 13,
    color: Colors.black87,
    fontFamily: 'San-francisco',
  );

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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/icons/restuarantlogo.svg',
                          width: 80,
                          height: 80,
                        ),
                        SizedBox(height: 10),
                        SizedBox(height: 10),
                        Text(
                          'Category - Food & Beverage | Compatibility - iOS & Android',
                          textAlign: TextAlign.center,
                          style: headerTxtStyle,
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => _launchInBrowser(
                                    'https://www.facebook.com/softpointautoid'),
                                child: SvgPicture.asset(
                                    'assets/icons/facebook.svg',
                                    width: 40,
                                    height: 40),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () => _launchInBrowser(
                                    'http://www.softpointcambodia.com'),
                                child: SvgPicture.asset('assets/icons/web.svg',
                                    width: 40, height: 40),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () => _makePhoneCall('tel:$_phone'),
                                child: SvgPicture.asset(
                                  'assets/icons/phone.svg',
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Divider(height: 1.2, color: Colors.black45),
                        SizedBox(height: 5),
                        Text(
                          'Hot Line Number (+855) 95659666 ( Telegram / Whatapp) ',
                          textAlign: TextAlign.center,
                          style: headerTxtStyle,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Copyright @ 2020 POINT SYSTEM ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black87,
                            fontFamily: 'San-francisco',
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
                                _checkCashInOperation(check: true);
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
                                _checkCashInOperation(check: false);
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
                              onTap: () => _logOut(),
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
    await Future.delayed(Duration(milliseconds: 100));
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
                        ? size.height * .45
                        : size.width >= 1000.0
                            ? size.height * .45
                            : size.height * .4,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: size.height * .01,
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
                  Text(
                    'KHR',
                    style: textStyle,
                  ),
                  Container(
                    width: size.width * .9,
                    margin: EdgeInsets.only(top: 5),
                    height: 50.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: TextFormField(
                        onChanged: (kh) {
                          _cashKhmer = kh;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: data[1]['cash_in'],
                          // labelText: 'KHR',
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
                  Text(
                    'USD',
                    style: textStyle,
                  ),
                  Container(
                    width: size.width * .8,
                    margin: EdgeInsets.only(top: 5),
                    height: 50.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: TextFormField(
                        onChanged: (us) => _cashUsd = us,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: data[0]['cash_in'],
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

  _showCashOutDialog({data}) async {
    await Future.delayed(Duration(milliseconds: 100));
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: size.height * .01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Cash Out'.toUpperCase(),
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
                      Icon(
                        Icons.money_off,
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  Text(
                    'KHR',
                    style: textStyle,
                  ),
                  Container(
                    width: size.width * .9,
                    margin: EdgeInsets.only(top: 5),
                    height: 50.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: TextFormField(
                        onChanged: (kh) {
                          _cashKhmer = kh;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
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
                  Text(
                    'USD',
                    style: textStyle,
                  ),
                  Container(
                    width: size.width * .8,
                    margin: EdgeInsets.only(top: 5),
                    height: 50.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: TextFormField(
                        onChanged: (us) => _cashUsd = us,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
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
                            onTap: () => _cashOut(data: data),
                            child: ActionButton(
                              active: true,
                              btnLabel: 'Cash Out',
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
