import 'package:flutter/material.dart';

class CenterLoadingIndicator extends StatelessWidget {
  final double width;
  final double height;
  const CenterLoadingIndicator({
    Key key,
    this.width = 120,
    this.height = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Image.asset(
          'assets/images/indicator.gif',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
