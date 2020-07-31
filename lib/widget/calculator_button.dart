import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utilities/style.main.dart';

class CaculateIcon extends StatelessWidget {
  const CaculateIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: 100,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[100],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            child: Material(
              child: InkWell(
                onTap: () {},
                child: Icon(
                  FontAwesomeIcons.minusCircle,
                  size: 20,
                  color: kPrimaryColor.withOpacity(.9),
                ),
              ),
            ),
          ),
          Container(
            width: 20,
            alignment: Alignment.center,
            child: Text("1"),
          ),
          Container(
            width: 40,
            child: Material(
              child: InkWell(
                onTap: () {},
                child: Icon(
                  FontAwesomeIcons.plusCircle,
                  size: 20,
                  color: kPrimaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
