import 'package:flutter/material.dart';
import 'package:pointrestaurant/screens/payment/components/content_card.dart';
import 'components/header_container.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          HeaderStack(height: MediaQuery.of(context).size.height * .45),
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
    );
  }
}
