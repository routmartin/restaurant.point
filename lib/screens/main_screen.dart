import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pointrestaurant/screens/invoice/invoice_screen.dart';
import 'package:pointrestaurant/screens/order/table_screen.dart';
import 'package:pointrestaurant/screens/profile/profile.dart';
import 'package:pointrestaurant/services/closeshift/closeshift_services.dart';
import 'package:pointrestaurant/utilities/path.dart';
import 'package:pointrestaurant/utilities/style.main.dart';

class MainScreenPage extends StatefulWidget {
  @override
  _MainScreenPageState createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  int _pageIndex = 0;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  List<Widget> _pageList;

  bool _connectionStatus = false;
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  @override
  void initState() {
    super.initState();
    initConnectivity();
    _checkCashInOperation();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _pageList = [
      TableModeScreen(),
      InvocieScreeen(),
      ProfileScreen(),
    ];
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

  _checkCashInOperation() async {
    await cashRegistration().then((data) {
      if (data[0]['cash_id'].toString().isEmpty) {
        setState(() {
          _pageIndex = 2;
        });
      }
    });
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
                  ],
                ),
              ),
            ),
          )
        : WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
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
                    _checkCashInOperation();
                    initConnectivity();
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
