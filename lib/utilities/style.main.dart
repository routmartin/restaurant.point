import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFe5002e);
const kPrimaryLightColor = Color(0xFFf7f7f7);
const scaffoldBackgroundColor = Color(0xFFfcfcfc);

const double iconSize = 17;
const Color bkColor = Color(0xfffcfcfc);
const radiusSize = 10;

BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Colors.grey[400],
      width: 0.8,
    ));
LinearGradient mainColorGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xFFe5002e),
    Color(0xFFbd0420),
  ],
);

TextStyle msgStyle = TextStyle(
  fontFamily: "San-francisco",
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);
TextStyle cancelStyle = TextStyle(
  fontFamily: "San-francisco",
  fontWeight: FontWeight.bold,
  color: Colors.red,
);
TextStyle homeTitle = TextStyle(
  fontSize: 20,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
  color: Color(0xff595959),
);

BoxDecoration mainShadow = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(7),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 4),
      color: Color(0xffd6d6d6),
      blurRadius: 20,
    )
  ],
);
var mainBackground = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xFFf2430c),
    Color(0xFFbd0420),
  ],
);
BoxDecoration cardShadow = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(5),
  boxShadow: [
    BoxShadow(
      color: Colors.black26,
      offset: Offset(0, 3),
      blurRadius: 20,
    )
  ],
);

TextStyle textStyle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 16,
  color: Colors.black87,
  fontFamily: 'San-francisco',
);
