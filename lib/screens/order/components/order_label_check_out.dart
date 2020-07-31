import 'package:flutter/material.dart';
import 'package:pointrestaurant/screens/order/popDialog/orderSummery.dart';

import 'package:pointrestaurant/utilities/style.main.dart';

class OrderLabelCheckOut extends StatelessWidget {
  const OrderLabelCheckOut({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Positioned(
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        width: size.width * .28,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Material(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(4),
          child: InkWell(
            onTap: () {
              orderSummary(context: context, size: size);
            },
            splashColor: Colors.white24,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '\$ 00.00',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'USA',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        'Order',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
