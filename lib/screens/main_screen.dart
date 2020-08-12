import 'package:bottom_animation/source/bottomnav_item.dart';
import 'package:bottom_animation/source/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pointrestaurant/screens/payment/payment_screen.dart';
import 'package:pointrestaurant/screens/pending/pending_screen.dart';
import '../screens/home/home_screen.dart';
import '../utilities/style.main.dart';

import 'order/table_screen.dart';

class MainScreenPage extends StatefulWidget {
  final userToken;
  MainScreenPage({this.userToken});
  @override
  _MainScreenPageState createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  int _pageIndex;
  List<Widget> _pageList;
  var items = <BottomNavItem>[
    BottomNavItem(
      title: 'HOME',
      iconData: Icons.home,
    ),
    BottomNavItem(title: 'ORDER', iconData: Icons.view_list),
    BottomNavItem(title: 'PENDING', iconData: Icons.timelapse),
    BottomNavItem(title: 'MY ACCOUNT', iconData: Icons.account_circle),
  ];
  @override
  void initState() {
    _pageIndex = 0;
    super.initState();
    _pageList = [
      HomeScreen(),
      TableScreen(),
      ChartScreen(),
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
    //   return MaterialApp(
    //     title: 'example',
    //     theme: ThemeData(
    //       primarySwatch: Colors.indigo,
    //       visualDensity: VisualDensity.adaptivePlatformDensity,
    //     ),
    //     home: Scaffold(
    //       backgroundColor: Colors.white70,
    //       bottomNavigationBar: BottomAnimation(
    //         selectedIndex: _pageIndex,
    //         items: items,
    //         backgroundColor: Colors.white,
    //         barHeight: 70,
    //         itemHoverHeight: 40,
    //         hoverAlignmentDuration: 400,
    //         iconSize: 30,
    //         onItemSelect: (value) {
    //           setState(() {
    //             _pageIndex = value;
    //           });
    //         },
    //         itemHoverColor: kPrimaryColor,
    //         itemHoverColorOpacity: .8,
    //         activeIconColor: Colors.white,
    //         deactiveIconColor: kPrimaryColor,
    //         barRadius: 10,
    //         textStyle: TextStyle(
    //           color: Colors.white,
    //           fontWeight: FontWeight.bold,
    //           fontSize: 12,
    //         ),
    //         itemHoverWidth: 120,
    //         itemHoverBorderRadius: 25,
    //       ),
    //       body: _pageList[_pageIndex],
    //     ),
    //   );
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
