import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/style.main.dart';

class CaculateIcon extends StatelessWidget {
  final String qty;
  final Function funcMinus;
  final Function funcPlus;
  const CaculateIcon({
    Key key,
    this.qty = '1',
    this.funcMinus,
    this.funcPlus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffE5E4E2),
      ),
      child: Row(
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
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        width: 25,
        height: 25,
        alignment: Alignment.centerRight,
        child: Material(
          borderRadius: BorderRadius.circular(15.0),
          color: kPrimaryColor,
          child: InkWell(
            splashColor: Colors.black45,
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
      ),
    );
  }
}
