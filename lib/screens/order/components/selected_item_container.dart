import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/style.main.dart';


class SelectedItemContainer extends StatelessWidget {
  const SelectedItemContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .2,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Selected Items',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w600,
              color: Color(0xff787878),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            '11',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
