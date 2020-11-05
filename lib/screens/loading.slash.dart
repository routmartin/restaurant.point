import 'package:flutter/material.dart';
import 'package:pointrestaurant/screens/login/login_screen.dart';
import 'package:pointrestaurant/screens/main_screen.dart';
import 'package:pointrestaurant/utilities/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import '../utilities/globals.dart' as globals;

class LoadingPage extends StatefulWidget {
  LoadingPage({Key key}) : super(key: key);
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
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
    loadSharePreferenc().then((data) {
      setState(() {
        globals.userToken = data != null ? data : 'no';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds:
          globals.userToken.length == 2 ? LoginScreen() : MainScreenPage(),
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
