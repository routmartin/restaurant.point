import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pointrestaurant/screens/order/table_mode_screen.dart';
import 'package:pointrestaurant/screens/payment/payment_screen.dart';

import '../screens/home/home_screen.dart';
import '../utilities/style.main.dart';

import 'order/menu_screen.dart';

class MainScreenPage extends StatefulWidget {
  final userToken;
  MainScreenPage({this.userToken});
  @override
  _MainScreenPageState createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  int _pageIndex;
  List<Widget> _pageList;

  @override
  void initState() {
    _pageIndex = 0;
    super.initState();
    _pageList = [
      HomeScreen(),
      TableModeScreen(),
      MenuScreen(),
      PaymentScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              ),
            ],
          ),
          child: BottomNavigationBar(
            selectedIconTheme: IconThemeData(color: kPrimaryColor),
            type: BottomNavigationBarType.fixed,
            elevation: 20.0,
            iconSize: 24,
            selectedFontSize: 13,
            unselectedFontSize: 12,
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: Color(0xFF828282),
            selectedLabelStyle: TextStyle(
                fontFamily: 'San-francisco', fontWeight: FontWeight.w800),
            unselectedLabelStyle: TextStyle(
                fontFamily: 'San-francisco', fontWeight: FontWeight.bold),
            currentIndex: _pageIndex,
            onTap: (index) {
              setState(() {
                _pageIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                title: Text(
                  'HOME',
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.view_list),
                title: Text(
                  'ORDERS',
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.timelapse,
                  size: 30,
                ),
                title: Text(
                  'Pending',
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text(
                  'MY ACCOUNT',
                ),
              ),
            ],
          ),
        ),
        body: _pageList[_pageIndex],
      ),
    );
  }
}

class BottonIcon extends StatelessWidget {
  final String iconName;
  const BottonIcon({
    Key key,
    this.iconName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/' + iconName,
      width: 30,
      height: 30,
    );
  }
}
