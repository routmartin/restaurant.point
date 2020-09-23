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
  String userToken = 'nolog';
  Future loadSharePreferenc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    globals.port = prefs.getString('Port');
    globals.ipAddress = prefs.getString('IP');
    return prefs.getString('userLog');
  }

  @override
  void initState() {
    super.initState();
    loadSharePreferenc().then((data) {
      if (data != null) {
        setState(() {
          userToken = data;
        });
        globals.userToken = userToken;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds:
          userToken == 'nolog' ? LoginScreen() : MainScreenPage(),
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
