import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/path.dart';

class CampanyHeaderContianer extends StatelessWidget {
  const CampanyHeaderContianer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
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
    );
  }
}
