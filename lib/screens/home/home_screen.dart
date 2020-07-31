import 'package:flutter/material.dart';
import '../../utilities/style.main.dart';
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
      backgroundColor: Color(0xfff0f0f0),
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
        child: Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 15,
            right: 15,
          ),
          color: scaffoldBackgroundColor,
          child: Column(
            children: <Widget>[
              ListScrollHome(
                size: size,
                title: 'PROMOTION',
                imgPath: 'assets/images/img4.jpg',
              ),
              SizedBox(
                height: 10,
              ),
              ListScrollHome(
                size: size,
                title: 'TOP SALE',
                imgPath: 'assets/images/img2.jpg',
              ),
              SizedBox(
                height: 10,
              ),
              ListScrollHome(
                size: size,
                title: 'POPULAR',
                imgPath: 'assets/images/img3.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
