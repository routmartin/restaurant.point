import 'package:flutter/material.dart';
import 'package:pointrestaurant/screens/payment/components/content_card.dart';
import 'package:pointrestaurant/utilities/style.main.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        kPrimaryColor,
                        Color(0xFFeb4438),
                      ],
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * .45,
                ),
                AppBar(
                  leading: Icon(
                    Icons.arrow_back_ios,
                    color: kPrimaryColor,
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  centerTitle: true,
                  title: Text(
                    "Payment",
                    style: TextStyle(
                      fontFamily: 'NothingYouCouldDo',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).padding.top,
                    ),
                    Expanded(
                      child: ContentCard(),
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
