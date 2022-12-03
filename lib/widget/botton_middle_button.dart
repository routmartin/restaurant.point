import 'package:flutter/material.dart';

class BottomMiddleButton extends StatelessWidget {
  final Widget sign;
  final double width;
  const BottomMiddleButton({this.sign, this.width: 25});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 25,
      decoration: BoxDecoration(
        color: Color(0xffcc2d2d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: sign,
      ),
    );
  }
}
