import 'package:flutter/material.dart';
import 'package:pointrestaurant/widget/botton_middle_button.dart';


class OrderItems extends StatelessWidget {
  const OrderItems({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Row(
        children: <Widget>[
          Text('Point Restaurant'),
          SizedBox(
            width: 5,
          ),
          BottomMiddleButton(
            sign: Text(
              'x',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 10),
          VerticalDivider(
            color: Colors.black,
            width: 2.2,
          )
        ],
      ),
    );
  }
}
