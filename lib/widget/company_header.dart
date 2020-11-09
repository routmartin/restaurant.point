import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 10),
                child: MediaQuery.of(context).size.width <= 500
                    ? SvgPicture.asset(
                        'assets/icons/pointsystem.svg',
                        fit: BoxFit.fitHeight,
                        height: 50,
                      )
                    : SvgPicture.asset(
                        'assets/icons/softpointlogo.svg',
                        fit: BoxFit.fitHeight,
                        height: 38,
                      ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
