import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/style.main.dart';

class CaculateIcon extends StatelessWidget {
  const CaculateIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffE5E4E2),
      ),
      child: Row(
        children: <Widget>[
          _buildIconButton(sysbol: '-', action: () {}),
          Container(
            width: 30,
            alignment: Alignment.center,
            child: Text(
              "1",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildIconButton(sysbol: '+', action: () {})
        ],
      ),
    );
  }

  _buildIconButton({String sysbol, Function action}) {
    return Container(
      width: 23,
      height: 23,
      alignment: Alignment.centerRight,
      child: Material(
        borderRadius: BorderRadius.circular(15.0),
        color: kPrimaryColor,
        child: InkWell(
          splashColor: Colors.white24,
          onTap: action,
          child: Center(
            child: Text(
              sysbol,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
