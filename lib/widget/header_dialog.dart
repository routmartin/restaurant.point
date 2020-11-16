import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pointrestaurant/utilities/path.dart';

class HeaderDialogSoftpoint extends StatelessWidget {
  final titleHeader;
  const HeaderDialogSoftpoint({
    Key key,
    this.titleHeader,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(
          companyLogo,
          width: 50,
          height: 50,
        ),
        Expanded(
          child: Text(
            titleHeader,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'San-francisco',
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
