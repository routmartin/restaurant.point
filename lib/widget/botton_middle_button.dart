import 'package:flutter/material.dart';

class BottomMiddleButton extends StatelessWidget {
  final Widget sign;
  final double width;
  const BottomMiddleButton({
    Key key,
    this.sign,
    this.width: 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 20,
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
