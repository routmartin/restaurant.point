import 'package:flutter/material.dart';
import 'package:pointrestaurant/screens/order/components/order_cal_icon.dart';
import 'package:pointrestaurant/screens/order/popDialog/special_offer.dart';
import 'package:pointrestaurant/utilities/style.main.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.35,
      color: Color(0xfff0f0f0),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.centerLeft,
            height: 70,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.2, color: Colors.grey),
              ),
            ),
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: _buildRowTitleItem(),
                      ),
                      _buildTotalPrice(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    CaculateIcon(),
                    SizedBox(width: 10),
                    _buildSpecilRequest(context)
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _buildSpecilRequest(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black54,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            specialRequest(context, size);
          },
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              "SPECIAL REQUEST",
              style: TextStyle(
                fontSize: 7,
                fontFamily: 'San-francisco',
                fontWeight: FontWeight.w800,
                letterSpacing: 1.02,
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildTotalPrice() {
    return Expanded(
      flex: 1,
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          "\$12.50",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  _buildRowTitleItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "Brown Suger Jelly",
          style: TextStyle(
            letterSpacing: 1.1,
            fontFamily: 'San-francisco',
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "\$ 12.50",
          style: TextStyle(
            fontFamily: 'San-francisco',
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
