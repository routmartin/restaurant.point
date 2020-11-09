import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/path.dart';
import 'package:pointrestaurant/utilities/style.main.dart';

class CaculateIcon extends StatelessWidget {
  final String qty;
  final Function funcMinus;
  final Function funcPlus;
  final double btnSize;
  final double btnRounder;
  final double wrapperWidth;
  final double wrapperHeight;
  const CaculateIcon({
    Key key,
    this.qty = '1',
    this.funcMinus,
    this.funcPlus,
    this.wrapperWidth = 150,
    this.wrapperHeight = 40,
    this.btnSize = 40,
    this.btnRounder = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wrapperWidth,
      height: wrapperHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: baseBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildIconButton(
              sysbol: '-', action: int.parse(qty) > 1 ? funcMinus : null),
          Container(
            width: 30,
            alignment: Alignment.center,
            child: Text(
              qty,
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildIconButton(sysbol: '+', action: funcPlus)
        ],
      ),
    );
  }

  _buildIconButton({String sysbol, Function action}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(btnRounder),
      child: Material(
        borderRadius: BorderRadius.circular(btnRounder),
        color: kPrimaryColor,
        child: InkWell(
          splashColor: Colors.black45,
          onTap: action,
          child: Container(
            width: btnSize,
            height: btnSize,
            alignment: Alignment.center,
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
