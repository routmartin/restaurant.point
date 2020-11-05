import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pointrestaurant/screens/invoice/invoice_screen.dart';
import 'package:pointrestaurant/screens/order/table_screen.dart';
import 'package:pointrestaurant/screens/profile/profile.dart';

import '../utilities/style.main.dart';

class MainScreenPage extends StatefulWidget {
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
      TableModeScreen(),
      InvocieScreeen(),
      Profile(),
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
                blurRadius: 15,
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 10.0,
            iconSize: 20,
            selectedItemColor: Colors.black,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            showUnselectedLabels: false,
            currentIndex: _pageIndex,
            onTap: (index) {
              setState(() {
                _pageIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/cart.svg',
                  width: 20,
                  height: 20,
                ),
                title: Text(
                  'ORDER',
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/invoice.svg',
                  width: 20,
                  height: 20,
                ),
                title: Text(
                  'INVOICE',
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/account.svg',
                  width: 20,
                  height: 20,
                ),
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
