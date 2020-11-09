import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/style.main.dart';

class ActionButton extends StatelessWidget {
  final String btnLabel;
  final bool active;
  const ActionButton({
    Key key,
    this.btnLabel,
    this.active = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? kPrimaryColor : Colors.black12,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 9,
        horizontal: 20,
      ),
      child: Text(
        btnLabel,
        style: TextStyle(
          fontSize: 13,
          decoration: TextDecoration.none,
          color: active ? Colors.white : Colors.black54,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
