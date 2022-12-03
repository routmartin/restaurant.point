import 'package:flutter/material.dart';
import 'package:pointrestaurant/widget/company_header.dart';

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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CampanyHeaderContianer(),
            Expanded(
              child: SingleChildScrollView(
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
            ),
          ],
        ),
      ),
    );
  }
}
