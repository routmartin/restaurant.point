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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 10,
                    color: Colors.black12,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Image.asset(
                      appbarLogo,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 10),
                      child: Text('SOFTPOINT AUTO ID',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'San-francisco',
                          )),
                    ),
                  )
                ],
              ),
            ),
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
