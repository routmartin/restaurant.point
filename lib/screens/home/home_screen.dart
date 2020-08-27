import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/style.main.dart';
import '../../utilities/path.dart';

import 'components/list_view_scroll.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 5,
        leading: Container(
          margin: EdgeInsets.only(left: 10),
          child: Image.asset(
            appbarLogo,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 20,
          left: 15,
          right: 15,
        ),
        child: Column(
          children: <Widget>[
            ListScrollHome(
              size: size,
              title: 'PROMOTION',
              imgPath: 'assets/images/img1.jpg',
            ),
            SizedBox(
              height: 10,
            ),
            ListScrollHome(
              size: size,
              title: 'TOP SALE',
              imgPath: 'assets/images/img1.jpg',
            ),
            SizedBox(
              height: 10,
            ),
            ListScrollHome(
              size: size,
              title: 'TOP SALE',
              imgPath: 'assets/images/img1.jpg',
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
