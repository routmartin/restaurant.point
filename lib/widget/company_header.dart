import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class CampanyHeaderContianer extends StatelessWidget {
  const CampanyHeaderContianer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            margin: MediaQuery.of(context).size.width >= 50
                ? EdgeInsets.only(left: 20)
                : EdgeInsets.only(left: 10),
            child: SvgPicture.asset(
              'assets/icons/restuarantlogo.svg',
              fit: BoxFit.fitHeight,
              height: 70,
            ),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              DigitalClock(
                digitAnimationStyle: Curves.elasticOut,
                is24HourTimeFormat: false,
                areaAligment: AlignmentDirectional.centerEnd,
                areaDecoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                hourMinuteDigitTextStyle: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 26,
                ),
                amPmDigitTextStyle: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
