import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:pointrestaurant/screens/login/login_screen.dart';
import 'package:pointrestaurant/screens/main_screen.dart';
import 'package:pointrestaurant/utilities/path.dart';
import 'package:pointrestaurant/utilities/style.main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import '../utilities/globals.dart' as globals;
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key key}) : super(key: key);
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool _connectionStatus = false;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future loadSharePreferenc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('Port')) {
      globals.port = prefs.getString('Port');
      globals.ipAddress = prefs.getString('IP');
      print('ip: ${globals.ipAddress}');
    } else {
      globals.ipAddress = '124.248.164.229';
      globals.port = '5006';
    }

    if (prefs.containsKey('bill')) {
      globals.bill = prefs.getInt('bill');
    }
    if (prefs.containsKey('pay')) {
      globals.pay = prefs.getInt('pay');
    }
    if (prefs.containsKey('reprint')) {
      globals.reprint = prefs.getInt('reprint');
    }

    return prefs.getString('userLog');
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    loadSharePreferenc().then((data) {
      setState(() {
        globals.userToken = data != null ? data : 'no';
      });
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        setState(() => _connectionStatus = true);
        break;
      case ConnectivityResult.none:
      default:
        setState(() => _connectionStatus = false);
        break;
    }
  }

  @override
  dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return !_connectionStatus
        ? Material(
            child: Container(
              color: baseBackgroundColor,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.signal_cellular_connected_no_internet_4_bar,
                      size: 50,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Intenet is not connected',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black87,
                        fontFamily: 'San-francisco',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Material(
                        color: kPrimaryColor,
                        child: InkWell(
                            onTap: () => initConnectivity(),
                            splashColor: Colors.black12,
                            child: Container(
                              alignment: Alignment.center,
                              width: 120,
                              height: 45,
                              child: Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : SplashScreen(
            seconds: 3,
            navigateAfterSeconds: globals.userToken.length == 2
                ? LoginScreen()
                : MainScreenPage(),
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
}
